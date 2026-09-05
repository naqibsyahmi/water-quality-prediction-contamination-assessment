CREATE OR REPLACE PROCEDURE `river-water-quality-prediction.river_water_quality_dataset.sp_final_incoming_data`()

BEGIN

CREATE OR REPLACE TABLE `river-water-quality-prediction.river_water_quality_dataset.final_incoming_river_water_quality`
AS

WITH wqi_calculations AS (

  SELECT
    *,

    -- Failed variable checks
    (
      IF(EC > 1000, 1, 0) +
      IF(SS_mgL > 50, 1, 0) +

      IF(pH < 6.5 OR pH > 8.5, 1, 0) +

      IF(TP_mgL > 0.2, 1, 0) +
      IF(NO2_N_mgL > 0.4, 1, 0) +
      IF(NO3_N_mgL > 7, 1, 0) +

      IF(DO_mgL < 5, 1, 0) +

      IF(Al_mgL > 0.5, 1, 0) +
      IF(Fe_mgL > 1, 1, 0) +
      IF(Mn_mgL > 0.1, 1, 0) +
      IF(Zn_mgL > 5, 1, 0) +
      IF(Cu_mgL > 0.02, 1, 0)

    ) AS failed_variables,

    -- Excursion calculations
    (
      IF(EC > 1000, (EC - 1000) / 1000, 0) +

      IF(SS_mgL > 50, (SS_mgL - 50) / 50, 0) +

      IF(pH < 6.5, (6.5 - pH), 0) +
      IF(pH > 8.5, (pH - 8.5), 0) +

      IF(TP_mgL > 0.2, (TP_mgL - 0.2) / 0.2, 0) +

      IF(
        NO2_N_mgL > 0.4,
        (NO2_N_mgL - 0.4) / 0.4,
        0
      ) +

      IF(
        NO3_N_mgL > 7,
        (NO3_N_mgL - 7) / 7,
        0
      ) +

      IF(
        DO_mgL < 5,
        (5 - DO_mgL) / 5,
        0
      ) +

      IF(
        Al_mgL > 0.5,
        (Al_mgL - 0.5) / 0.5,
        0
      ) +

      IF(
        Fe_mgL > 1,
        (Fe_mgL - 1) / 1,
        0
      ) +

      IF(
        Mn_mgL > 0.1,
        (Mn_mgL - 0.1) / 0.1,
        0
      ) +

      IF(
        Zn_mgL > 5,
        (Zn_mgL - 5) / 5,
        0
      ) +

      IF(
        Cu_mgL > 0.02,
        (Cu_mgL - 0.02) / 0.02,
        0
      )

    ) AS excursion

  FROM `river-water-quality-prediction.river_water_quality_dataset.processed_incoming_river_water_quality`

)

SELECT * EXCEPT(failed_variables, excursion),

  -- Final WQI
  100 -
  (
    SQRT(
      POW((failed_variables / 12.0) * 100, 2) +
      POW((failed_variables / 12.0) * 100, 2) +
      POW(((excursion / 12.0) / ((0.01 * (excursion / 12.0)) + 0.01)), 2)) / 1.732
  ) AS WQI

FROM wqi_calculations;

END;