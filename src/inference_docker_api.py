import os
import time
import requests
import pandas as pd
import joblib

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DATA_DIR = os.path.join(BASE_DIR, "data")
MODEL_DIR = os.path.join(BASE_DIR, "model")

# Load Test Data
feature_cols = joblib.load(os.path.join(MODEL_DIR, "feature_cols.pkl"))

test_df = pd.read_csv(os.path.join(DATA_DIR, "test_stream_data.csv"))
test_df = test_df[feature_cols]

print(f"Loaded test data: " f"{test_df.shape}")

# API Endpoint
API_URL = "http://localhost:8501/predict_river_water_quality"

def main():
    print("\nStarting API inference...\n")
    for idx, row in test_df.iterrows():
        
        # Convert row into JSON payload
        payload = {"features": row.to_dict()}
    
        try:
            # Send request
            response = requests.post(API_URL, json=payload)
            result = response.json()
    
            print(f"Record: {idx+1}")
    
            print(f"Predicted WQI: " f"{result['predicted_wqi']}")
    
            print(f"Contamination Level: " f"{result['contamination_level']}")
    
            print(f"Alert Triggered: " f"{result['alert_triggered']}")
    
            print("-" * 50)
    
        except Exception as e:
            print(f"API request failed: {e}")

        time.sleep(2)

if __name__ == "__main__":
    main()
