CREATE OR REPLACE TABLE `river-water-quality-prediction.river_water_quality_dataset.prediction_results_river_water_quality`
(
    prediction_timestamp TIMESTAMP,
    pipeline_run_id STRING,

    River STRING,
    Country STRING,
    Latitude FLOAT64,
    Longitude FLOAT64,

    actual_wqi FLOAT64,
    predicted_wqi FLOAT64,

    contamination_level STRING,
    alert_triggered BOOL,

    EC FLOAT64,
    Temp_C FLOAT64,
    SS_mgL FLOAT64,
    pH FLOAT64,
    TP_mgL FLOAT64,
    NO2_N_mgL FLOAT64,
    NO3_N_mgL FLOAT64,
    DO_mgL FLOAT64,

    Al_mgL FLOAT64,
    Fe_mgL FLOAT64,
    Mn_mgL FLOAT64,
    Zn_mgL FLOAT64,
    Cu_mgL FLOAT64,

    Chl_a_mgL FLOAT64,

    NDVI FLOAT64,
    NDWI FLOAT64,
    MNDWI FLOAT64,
    NDBI FLOAT64,
    NDMI FLOAT64,
    NDTI FLOAT64
)
PARTITION BY DATE(prediction_timestamp)
CLUSTER BY River, Country, contamination_level;