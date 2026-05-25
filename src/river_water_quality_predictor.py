import os
import pickle
import joblib
import torch
import torch.nn as nn
import pandas as pd
import requests


from dotenv import load_dotenv
from datetime import datetime
from fastapi import FastAPI
from pydantic import BaseModel

load_dotenv()

app = FastAPI(
    title="River Water Quality Prediction & Contamination Detection API",
    description="Hybrid NN-XGBoost River Water Quality Prediction Endpoint",
    version="1.0"
)

TELEGRAM_BOT_TOKEN = os.environ.get("TELEGRAM_BOT_TOKEN")
TELEGRAM_CHAT_ID = os.environ.get("TELEGRAM_CHAT_ID")
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODEL_DIR = os.path.join(BASE_DIR, "model")

with open(os.path.join(MODEL_DIR, "best_hybrid_nn_xgb_model.pkl"), "rb") as f:
    hybrid_model = pickle.load(f)
scaler = joblib.load(os.path.join(MODEL_DIR, "scaler.pkl"))
feature_cols = joblib.load(os.path.join(MODEL_DIR, "feature_cols.pkl"))

# Define NN Architecture
class WaterQualityNN(nn.Module):

    def __init__(self, num_features):
        super(WaterQualityNN, self).__init__()
        self.feature_extractor = nn.Sequential(

            nn.Linear(num_features, 128),
            nn.BatchNorm1d(128),
            nn.ReLU(),
            nn.Dropout(0.2),
            
            nn.Linear(128, 64),
            nn.BatchNorm1d(64),
            nn.ReLU(),
            nn.Dropout(0.2)
        )
        self.regressor = nn.Linear(64, 1)

    def forward(self, x):

        features = self.feature_extractor(x)
        output = self.regressor(features)
        return output, features

# Load trained NN model
num_features = len(feature_cols)
nn_model = WaterQualityNN(num_features)

nn_model.load_state_dict(torch.load(os.path.join(MODEL_DIR, "best_nn_model.pth"), map_location=torch.device("cpu")))
nn_model.eval()

def send_telegram_alert(predicted_wqi, contamination_level):
    message = (
        f"River Water Quality Alert\n\n"
        f"Predicted WQI: {predicted_wqi:.2f}\n"
        f"Contamination Level: "
        f"{contamination_level}\n\n"
        f"Potential contamination detected.\n"
        f"Immediate inspection recommended.\n\n"
        f"Timestamp: {datetime.now()}"
    )

    telegram_url = (
        f"https://api.telegram.org/bot"
        f"{TELEGRAM_BOT_TOKEN}/sendMessage"
    )
    payload = {
        "chat_id": TELEGRAM_CHAT_ID,
        "text": message
    }

    try:
        response = requests.post(
            telegram_url,
            json=payload,
            timeout=10
        )

        if response.status_code == 200:
            print("Telegram alert sent successfully.")

        else:
            print(f"Telegram alert failed: " f"{response.status_code}")
            print(response.text)

    except Exception as e:
        print(f"Telegram exception: {e}")
        

def get_contamination_level(wqi):
    if wqi >= 90:
        return "Excellent"
    elif wqi >= 80:
        return "Good"
    elif wqi >= 60:
        return "Fair"
    elif wqi >= 45:
        return "Marginal"
    else:
        return "Poor"

class WaterQualityRequest(BaseModel):
    features: dict


@app.get("/")
def health_check():
    return {"status": "healthy", "message": "River Water Quality Prediction API is running"}

# Prediction endpoint
@app.post("/predict_river_water_quality")
def predict_river_water_quality(request: WaterQualityRequest):
    
    # Convert incoming JSON into dataframe
    input_df = pd.DataFrame([request.features])
    input_df = input_df[feature_cols]

    # Scale features
    scaled_input = scaler.transform(input_df)

    # Convert to tensor
    input_tensor = torch.tensor(scaled_input, dtype=torch.float32)

    # Extract NN features
    with torch.no_grad():
        _, extracted_features = nn_model(input_tensor)

    extracted_features_np = extracted_features.numpy()

    # Predict WQI
    predicted_wqi = hybrid_model.predict(extracted_features_np)[0]
    predicted_wqi = float(predicted_wqi)

    # Determine contamination level
    contamination_level = get_contamination_level(predicted_wqi)

    # Alert Logic
    alert_triggered = False

    if contamination_level in ["Marginal", "Poor"]:
        alert_triggered = True
        send_telegram_alert(predicted_wqi, contamination_level)

    return {"predicted_wqi": round(predicted_wqi, 2), "contamination_level": contamination_level, "alert_triggered": alert_triggered}