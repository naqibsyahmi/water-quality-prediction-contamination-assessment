import os
import time
import requests
import pandas as pd
import joblib

from google.auth.transport.requests import Request
from google.oauth2 import id_token

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DATA_DIR = os.path.join(BASE_DIR, "data")
MODEL_DIR = os.path.join(BASE_DIR, "model")

# Load Test Data
feature_cols = joblib.load(os.path.join(MODEL_DIR, "feature_cols.pkl"))

test_df = pd.read_csv(os.path.join(DATA_DIR, "test_stream_data.csv"))
test_df = test_df[feature_cols]

print(f"Loaded test data: " f"{test_df.shape}")

# Cloud Run Endpoint
SERVICE_URL = "https://river-water-quality-api-988886574897.asia-southeast1.run.app"
API_URL = f"{SERVICE_URL}/predict_river_water_quality"

# Generate identity token
auth_req = Request()
token = id_token.fetch_id_token(auth_req, SERVICE_URL)

headers = {"Authorization": f"Bearer {token}"}

def main():
    print("\nStarting API inference...\n")
    for idx, row in test_df.iterrows():

        clean_row = row.replace([float("inf"), float("-inf")], 0).fillna(0)
        
        # Convert row into JSON payload
        payload = {"features": clean_row.to_dict()}
    
        try:
            # Send request
            response = requests.post(API_URL, json=payload, headers=headers, timeout=30)

            if response.status_code != 200:
                print(f"\n Request Failed")
                print(f"Record: {idx+1}")
                print(f"HTTP Status Code: {response.status_code}")
                print(f"Response Body:\n{response.text}")
                print("-" * 50)
                continue
            try:
                result = response.json()

            except requests.exceptions.JSONDecodeError:
                print(f"\nJSON Decode Failed")
                print(f"Record: {idx+1}")
                print(f"Raw Response:\n{response.text}")
                print("-" * 50)
                continue
                
            print(f"Record: {idx+1}")
            print(f"Predicted WQI: " f"{result['predicted_wqi']}")
            print(f"Contamination Level: " f"{result['contamination_level']}")
            print(f"Alert Triggered: " f"{result['alert_triggered']}")
            print("-" * 50)
    
        except Exception as e:
            print(f"Unexpected Error: {e}")

if __name__ == "__main__":
    main()