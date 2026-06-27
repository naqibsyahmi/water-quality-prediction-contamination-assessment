import requests
import pandas as pd
import joblib
import os

from google.auth.transport.requests import Request
from google.oauth2 import id_token

# Load CSV
stream_df = pd.read_csv("test_stream_data.csv")

# Load Current Index
INDEX_FILE = "current_index.txt"

if not os.path.exists(INDEX_FILE):
    with open(INDEX_FILE, "w") as f:
        f.write("0")

# Cloud Run URL
SERVICE_URL = ("https://river-water-quality-api-988886574897." "asia-southeast1.run.app")

API_URL = (f"{SERVICE_URL}"f"/predict_river_water_quality")

# Main Cloud Function
def automated_river_water_quality_monitoring(request):

    # Read Current Index
    with open(INDEX_FILE, "r") as f:
        current_index = int(f.read())

    # Restart if exceeds dataset
    if current_index >= len(stream_df):

        current_index = 0

    # Get Current Row
    row = stream_df.iloc[current_index]

    clean_row = row.replace([float("inf"), float("-inf")], 0).fillna(0)

    payload = {"features": clean_row.to_dict()}

    # Generate Auth Token
    auth_req = Request()

    token = id_token.fetch_id_token(
        auth_req,
        SERVICE_URL
    )

    headers = {"Authorization": f"Bearer {token}"}

    # Call Cloud Run
    try:
        response = requests.post(API_URL, json=payload,
                                 headers=headers, timeout=30)

    except Exception as e:
        return {"status": "error", "message": (f"Unexpected request error: {e}")}

    if response.status_code != 200:
        return {"status": "error", "status_code": response.status_code, "message": response.text}
                
    result = response.json()
    print(result)

    # Update Index
    current_index += 1

    with open(INDEX_FILE, "w") as f:
        f.write(str(current_index))

    return result