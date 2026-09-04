import functions_framework
import math
import os
import requests

from datetime import datetime, date
from google.cloud import storage
from google.cloud import bigquery
from google.auth.transport.requests import Request
from google.oauth2 import id_token

# Environment variables
PROJECT_ID = os.environ.get("PROJECT_ID")
DATASET_ID = os.environ.get("DATASET_ID")

INCOMING_NEW_DATA_TABLE = os.environ.get("INCOMING_NEW_DATA_TABLE")
INCOMING_FINAL_DATA_TABLE = os.environ.get("INCOMING_FINAL_DATA_TABLE")
PREDICTION_RESULTS_TABLE = os.environ.get("PREDICTION_RESULTS_TABLE")

# Cloud Run endpoint
SERVICE_URL = os.environ.get("SERVICE_URL")
API_URL = f"{SERVICE_URL}/predict_river_water_quality"

# Telegram bot
TELEGRAM_BOT_TOKEN = os.environ.get("TELEGRAM_BOT_TOKEN")
TELEGRAM_CHAT_ID = os.environ.get("TELEGRAM_CHAT_ID")

storage_client = storage.Client()
bq_client = bigquery.Client()

@functions_framework.cloud_event
def process_gcs_upload(cloud_event):
    data = cloud_event.data

    # File metadata
    bucket = data["bucket"]
    file_name = data["name"]
    size = data["size"]
    content_type = data["contentType"]
    time_created = data["timeCreated"]
    updated = data["updated"]
    generation = data["generation"]

    # Event metadata
    event_id = cloud_event["id"]
    event_type = cloud_event["type"]
    ingestion_time = datetime.utcnow().isoformat()
    pipeline_run_id = f"run_{event_id}"

    # Only process raw files in new/
    if not file_name.startswith("new/"):
        print(f"[SKIPPED] File outside 'new' folder: {file_name}")
        return

    # Only process raw csv files
    if not file_name.endswith(".csv"):
        print(f"[SKIPPED] Non-CSV file uploaded: {file_name}")
        return

    source_blob = storage_client.bucket(bucket).blob(file_name)

    if not source_blob.exists():
        print(f"[SKIPPED] File no longer exists: gs://{bucket}/{file_name}")
        return

    print("=" * 80)
    print("RIVER WATER QUALITY PIPELINE TRIGGERED")
    print("=" * 80)

    print(f"Pipeline Run ID : {pipeline_run_id}")
    print(f"Event ID       : {event_id}")
    print(f"Event Type     : {event_type}")
    print(f"Trigger Time   : {datetime.utcnow().isoformat()} UTC")

    print(f"Bucket         : {bucket}")
    print(f"File Name      : {file_name}")
    print(f"File Size      : {size} bytes")
    print(f"Content Type   : {content_type}")

    print(f"Created Time   : {time_created}")
    print(f"Updated Time   : {updated}")
    print(f"Generation     : {generation}")

    print(f"GCS Path       : gs://{bucket}/{file_name}")

    print("[STATUS] File accepted for processing")

    try:
        load_data_to_staging_table(
            bucket=bucket,
            file_name=file_name,
            pipeline_run_id=pipeline_run_id,
            ingestion_time=ingestion_time,
            event_id=event_id,
        )

        run_bq_processing()

        send_final_data_to_cloud_run_api(pipeline_run_id)

        move_raw_data_to_archive(
            bucket_name=bucket,
            file_name=file_name,
            pipeline_run_id=pipeline_run_id,
        )

        print("[SUCCESS] Pipeline completed succesfully")

    except Exception as e:
        print(f"[ERROR] Pipeline failed: {str(e)}")
        raise

def make_json_serializable(value):
    if value is None:
        return None
    if isinstance(value, (datetime, date)):
        return value.isoformat()
    if isinstance(value, float) and (math.isnan(value) or math.isinf(value)):
        return None
    return value

def load_data_to_staging_table(bucket, file_name, pipeline_run_id, ingestion_time, event_id):
    uri = f"gs://{bucket}/{file_name}"
    table_id = f"{PROJECT_ID}.{DATASET_ID}.{INCOMING_NEW_DATA_TABLE}"

    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        skip_leading_rows=1,
        autodetect=True,
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
    )

    load_job = bq_client.load_table_from_uri(
        uri,
        table_id,
        job_config=job_config,
    )

    load_job.result()

    print(f"[STATUS] CSV appended into staging BigQuery table: {table_id}")
    print(f"[STATUS] Source URI: {uri}")
    print(f"[STATUS] Pipeline Run ID: {pipeline_run_id}")
    print(f"[STATUS] Event ID: {event_id}")

def move_raw_data_to_archive(bucket_name, file_name, pipeline_run_id):
    bucket = storage_client.bucket(bucket_name)
    source_blob = bucket.blob(file_name)

    archive_file_name = file_name.replace("new/", "archive/", 1)

    bucket.copy_blob(source_blob, bucket, archive_file_name)

    source_blob.delete()

    print(f"[STATUS] File moved to archive: gs://{bucket_name}/{archive_file_name}")
    print(f"[STATUS] Original file removed from: gs://{bucket_name}/{file_name}")

def run_bq_processing():

    procedures = [
        "CALL `river-water-quality-prediction.river_water_quality_dataset.sp_map_incoming_data`()",
        "CALL `river-water-quality-prediction.river_water_quality_dataset.sp_clean_incoming_data`()",
        "CALL `river-water-quality-prediction.river_water_quality_dataset.sp_process_incoming_data`()",
        "CALL `river-water-quality-prediction.river_water_quality_dataset.sp_final_incoming_data`()"
    ]

    for procedure in procedures:
        print(f"[STATUS] Executing: {procedure}")

        job = bq_client.query(procedure)
        job.result()

        print("[STATUS] Completed")

def save_prediction_to_bq(row_dict, result, pipeline_run_id):
    table_id = f"{PROJECT_ID}.{DATASET_ID}.{PREDICTION_RESULTS_TABLE}"

    prediction_row = {
        "prediction_timestamp": datetime.utcnow().isoformat(),
        "pipeline_run_id": pipeline_run_id,
        "River": row_dict.get("River"),
        "Country": row_dict.get("Country"),
        "Latitude": row_dict.get("Latitude"),
        "Longitude": row_dict.get("Longitude"),
        "actual_wqi": row_dict.get("WQI"),
        "predicted_wqi": result.get("predicted_wqi"),
        "contamination_level": result.get("contamination_level"),
        "alert_triggered": result.get("alert_triggered"),
    }

    for key, value in row_dict.items():
        if key not in prediction_row and key != "WQI":
            prediction_row[key] = make_json_serializable(value)

    errors = bq_client.insert_rows_json(table_id, [prediction_row])

    if errors:
        print("[ERROR] Failed to save prediction to BigQuery")
        print(errors)
    else:
        print("[STATUS] Prediction saved to BigQuery")

def send_summary_telegram_alert(contaminated_locations, pipeline_run_id):
    message_lines = [
        "River Water Quality Alert",
        "",
        f"Pipeline Run ID: {pipeline_run_id}",
        f"{len(contaminated_locations)} contaminated location(s) detected.",
        ""
    ]

    for idx, loc in enumerate(contaminated_locations, start=1):
        message_lines.extend([
            f"{idx}. {loc.get('river')} ({loc.get('country')})",
            f"Predicted WQI: {loc.get('predicted_wqi'):.2f}",
            f"Level: {loc.get('contamination_level')}",
            f"Location: {loc.get('latitude')}, {loc.get('longitude')}",
            ""
        ])

    message_lines.extend([
        "Immediate inspection recommended.",
        "",
        f"Timestamp: {datetime.utcnow().isoformat()} UTC"
    ])

    telegram_url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"

    payload = {"chat_id": TELEGRAM_CHAT_ID, "text": "\n".join(message_lines)}

    response = requests.post(
        telegram_url,
        json=payload,
        timeout=30
    )

    if response.status_code == 200:
        print("[STATUS] Telegram summary alert sent.")

    else:
        print("[ERROR] Telegram alert failed")
        print(response.status_code)
        print(response.text)

def send_final_data_to_cloud_run_api(pipeline_run_id):
    final_table_id = f"{PROJECT_ID}.{DATASET_ID}.{INCOMING_FINAL_DATA_TABLE}"

    query = f"""
        SELECT *
        FROM `{final_table_id}`
    """

    # Generate identity token
    auth_req = Request()
    token = id_token.fetch_id_token(auth_req, SERVICE_URL)

    headers = {"Authorization": f"Bearer {token}"}

    rows = bq_client.query(query).result()

    prediction_count = 0
    contaminated_locations = []

    exclude_cols = ["WQI", "River", "Country",
                    "Latitude", "Longitude", "Date"
    ]

    print("[STATUS] Starting Cloud Run API inference...")

    for idx, row in enumerate(rows):
        row_dict = dict(row)

        features = {key: value for key, value in row_dict.items() if key not in exclude_cols}

        clean_features = {}

        for key, value in features.items():
            if value is None:
                clean_features[key] = 0

            elif isinstance(value, float) and (math.isnan(value) or math.isinf(value)):
                clean_features[key] = 0

            else:
                clean_features[key] = value

        payload = {
            "features": clean_features
        }

        try:
            response = requests.post(
                API_URL,
                json=payload,
                headers=headers,
                timeout=30
            )

            if response.status_code != 200:
                print("[ERROR] API request failed")
                print(f"Record: {idx + 1}")
                print(f"HTTP Status Code: {response.status_code}")
                print(f"Response Body: {response.text}")
                print("-" * 50)
                continue

            result = response.json()

            save_prediction_to_bq(row_dict, result, pipeline_run_id)

            if result["contamination_level"] in ["Marginal", "Poor"]:
                contaminated_locations.append({
                    "river": row_dict.get("River"),
                    "country": row_dict.get("Country"),
                    "latitude": row_dict.get("Latitude"),
                    "longitude": row_dict.get("Longitude"),
                    "predicted_wqi": result["predicted_wqi"],
                    "contamination_level": result["contamination_level"]
                })

            print(f"Record: {idx + 1}")
            print(f"Predicted WQI: {result['predicted_wqi']}")
            print(f"Contamination Level: {result['contamination_level']}")
            print(f"Alert Triggered: {result['alert_triggered']}")
            print("-" * 50)

            prediction_count += 1

        except Exception as e:
            print(f"[ERROR] Unexpected API error for record {idx + 1}: {e}")

    print(f"[STATUS] Total predictions sent to API: {prediction_count}")

    if contaminated_locations:
        send_summary_telegram_alert(contaminated_locations, pipeline_run_id)

    else:
        print("[STATUS] No Marginal or Poor contamination detected.")