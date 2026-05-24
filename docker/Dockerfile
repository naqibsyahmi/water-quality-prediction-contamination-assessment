# Base Image
FROM python:3.12-slim

# Environment Variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set Working Directory
WORKDIR /app

# Copy Requirements
COPY requirements_api.txt .

# Install Dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements_api.txt

# Copy Entire Project
COPY . .

# Expose API Port
EXPOSE 8501

# Start FastAPI Application
CMD ["uvicorn", "src.river_water_quality_predictor:app", "--host", "0.0.0.0", "--port", "8501"]