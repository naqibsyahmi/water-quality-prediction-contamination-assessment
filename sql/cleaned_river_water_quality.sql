CREATE OR REPLACE TABLE `river-water-quality-prediction.river_water_quality_dataset.cleaned_river_water_quality`
AS

WITH validated_data AS (

  SELECT

    * REPLACE (

      -- Replace physically impossible negative concentrations with 0
      GREATEST(SS_mgL, 0) AS SS_mgL,
      GREATEST(DO_mgL, 0) AS DO_mgL,

      -- Aluminium:
      -- England values are assumed to be in µg/L
      -- Convert England only from µg/L to mg/L
      CASE
        WHEN Country = 'England'
          THEN GREATEST(Al_mgL, 0) / 1000
        ELSE GREATEST(Al_mgL, 0)
      END AS Al_mgL,

      GREATEST(Fe_mgL, 0) AS Fe_mgL,
      GREATEST(Mn_mgL, 0) AS Mn_mgL,
      GREATEST(Zn_mgL, 0) AS Zn_mgL,
      GREATEST(Cu_mgL, 0) AS Cu_mgL,
      GREATEST(Chl_a_mgL, 0) AS Chl_a_mgL

    )

  FROM `river-water-quality-prediction.river_water_quality_dataset.mapped_river_water_quality`

  -- Remove physically invalid pH values
  -- Keep NULL pH because it will be median-imputed later
  WHERE
    pH IS NULL
    OR (pH >= 0 AND pH <= 14)
),

median_values AS (

  SELECT

    -- Water quality variables
    APPROX_QUANTILES(EC, 2)[OFFSET(1)] AS median_EC,
    APPROX_QUANTILES(Temp_C, 2)[OFFSET(1)] AS median_Temp_C,
    APPROX_QUANTILES(SS_mgL, 2)[OFFSET(1)] AS median_SS_mgL,
    APPROX_QUANTILES(pH, 2)[OFFSET(1)] AS median_pH,
    APPROX_QUANTILES(TP_mgL, 2)[OFFSET(1)] AS median_TP,
    APPROX_QUANTILES(NO2_N_mgL, 2)[OFFSET(1)] AS median_NO2,
    APPROX_QUANTILES(NO3_N_mgL, 2)[OFFSET(1)] AS median_NO3,
    APPROX_QUANTILES(DO_mgL, 2)[OFFSET(1)] AS median_DO,
    APPROX_QUANTILES(Al_mgL, 2)[OFFSET(1)] AS median_Al,
    APPROX_QUANTILES(Fe_mgL, 2)[OFFSET(1)] AS median_Fe,
    APPROX_QUANTILES(Mn_mgL, 2)[OFFSET(1)] AS median_Mn,
    APPROX_QUANTILES(Zn_mgL, 2)[OFFSET(1)] AS median_Zn,
    APPROX_QUANTILES(Cu_mgL, 2)[OFFSET(1)] AS median_Cu,
    APPROX_QUANTILES(Chl_a_mgL, 2)[OFFSET(1)] AS median_Chl_a_mgL,

    -- Satellite bands
    APPROX_QUANTILES(nir, 2)[OFFSET(1)] AS median_nir,
    APPROX_QUANTILES(red, 2)[OFFSET(1)] AS median_red,
    APPROX_QUANTILES(green, 2)[OFFSET(1)] AS median_green,
    APPROX_QUANTILES(swir16, 2)[OFFSET(1)] AS median_swir16,
    APPROX_QUANTILES(swir22, 2)[OFFSET(1)] AS median_swir22,
    APPROX_QUANTILES(blue, 2)[OFFSET(1)] AS median_blue

  FROM validated_data
)

SELECT

  p.* REPLACE (

    -- Water quality variables
    IFNULL(EC, median_EC) AS EC,
    IFNULL(Temp_C, median_Temp_C) AS Temp_C,
    IFNULL(SS_mgL, median_SS_mgL) AS SS_mgL,
    IFNULL(pH, median_pH) AS pH,
    IFNULL(TP_mgL, median_TP) AS TP_mgL,
    IFNULL(NO2_N_mgL, median_NO2) AS NO2_N_mgL,
    IFNULL(NO3_N_mgL, median_NO3) AS NO3_N_mgL,
    IFNULL(DO_mgL, median_DO) AS DO_mgL,
    IFNULL(Al_mgL, median_Al) AS Al_mgL,
    IFNULL(Fe_mgL, median_Fe) AS Fe_mgL,
    IFNULL(Mn_mgL, median_Mn) AS Mn_mgL,
    IFNULL(Zn_mgL, median_Zn) AS Zn_mgL,
    IFNULL(Cu_mgL, median_Cu) AS Cu_mgL,
    IFNULL(Chl_a_mgL, median_Chl_a_mgL) AS Chl_a_mgL,

    -- Satellite bands
    IFNULL(nir, median_nir) AS nir,
    IFNULL(red, median_red) AS red,
    IFNULL(green, median_green) AS green,
    IFNULL(swir16, median_swir16) AS swir16,
    IFNULL(swir22, median_swir22) AS swir22,
    IFNULL(blue, median_blue) AS blue

  )

FROM validated_data p

CROSS JOIN median_values;