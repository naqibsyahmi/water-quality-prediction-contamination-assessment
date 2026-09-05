CREATE OR REPLACE PROCEDURE `river-water-quality-prediction.river_water_quality_dataset.sp_clean_incoming_data`()

BEGIN

CREATE OR REPLACE TABLE `river-water-quality-prediction.river_water_quality_dataset.cleaned_incoming_river_water_quality`
AS

WITH median_values AS (

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

  FROM
  `river-water-quality-prediction.river_water_quality_dataset.incoming_river_water_quality`
)

SELECT

  p.* REPLACE(

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

FROM
`river-water-quality-prediction.river_water_quality_dataset.incoming_river_water_quality` p,
median_values;

END;