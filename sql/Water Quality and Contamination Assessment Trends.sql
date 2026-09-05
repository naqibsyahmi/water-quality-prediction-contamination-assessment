CREATE OR REPLACE VIEW `river-water-quality-prediction.river_water_quality_dataset.water_quality_contamination_assessment_trends`
AS

SELECT
    Date,

    EXTRACT(YEAR FROM Date) AS Year,
    EXTRACT(MONTH FROM Date) AS Month_Number,
    FORMAT_DATE('%B', Date) AS Month,

    FORMAT_DATE('%B', Date) AS Month_Label,

    CONCAT(
        LPAD(CAST(EXTRACT(MONTH FROM Date) AS STRING), 2, '0'),
        ' - ',
        FORMAT_DATE('%B', Date)
    ) AS Month_Label_Sortable,

    DATE_TRUNC(Date, WEEK(MONDAY)) AS Week_Start,
    DATE_TRUNC(Date, MONTH) AS Month_Start,
    DATE_TRUNC(Date, YEAR) AS Year_Start,

    CAST(CEIL(EXTRACT(DAY FROM Date) / 7.0) AS INT64) AS Week_Number_In_Month,

    CONCAT(
        'Week ',
        CAST(CAST(CEIL(EXTRACT(DAY FROM Date) / 7.0) AS INT64) AS STRING)
    ) AS Week_Label,

    CONCAT(
        CAST(CAST(CEIL(EXTRACT(DAY FROM Date) / 7.0) AS INT64) AS STRING),
        ' - Week ',
        CAST(CAST(CEIL(EXTRACT(DAY FROM Date) / 7.0) AS INT64) AS STRING)
    ) AS Week_Label_Sortable,

    River,
    Country,
    contamination_level,
    prediction_timestamp,

    variable,
    value

FROM `river-water-quality-prediction.river_water_quality_dataset.prediction_results_river_water_quality`

UNPIVOT
(
    value FOR variable IN (
        EC,
        Temp_C,
        SS_mgL,
        pH,
        TP_mgL,
        NO2_N_mgL,
        NO3_N_mgL,
        DO_mgL,
        Al_mgL,
        Fe_mgL,
        Mn_mgL,
        Zn_mgL,
        Cu_mgL,
        Chl_a_mgL,
        red,
        green,
        blue,
        nir,
        swir16,
        swir22,
        NDVI,
        NDWI,
        MNDWI,
        NDBI,
        NDMI,
        NDTI
    )
);