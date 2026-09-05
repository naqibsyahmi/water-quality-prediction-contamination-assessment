CREATE OR REPLACE VIEW
`river-water-quality-prediction.river_water_quality_dataset.contamination_percentage_summary`
AS

WITH base AS (

  -- Weekly
  SELECT
    'Weekly' AS period_type,
    Year,
    Month,
    Month_Number,
    Week_Label_Sortable AS Period,
    Week_Number_In_Month AS Period_Order,
    Country,
    River,
    contamination_level,
    COUNT(*) AS contamination_count
  FROM `river-water-quality-prediction.river_water_quality_dataset.variable_trends`
  GROUP BY
    Year, Month, Month_Number,
    Period, Period_Order,
    Country, River, contamination_level

  UNION ALL

  -- Monthly
  SELECT
    'Monthly' AS period_type,
    Year,
    Month,
    Month_Number,
    Month AS Period,
    Month_Number AS Period_Order,
    Country,
    River,
    contamination_level,
    COUNT(*) AS contamination_count
  FROM `river-water-quality-prediction.river_water_quality_dataset.variable_trends`
  GROUP BY
    Year, Month, Month_Number,
    Period, Period_Order,
    Country, River, contamination_level

  UNION ALL

  -- Yearly
  SELECT
    'Yearly' AS period_type,
    Year,
    NULL AS Month,
    NULL AS Month_Number,
    CAST(Year AS STRING) AS Period,
    Year AS Period_Order,
    Country,
    River,
    contamination_level,
    COUNT(*) AS contamination_count
  FROM `river-water-quality-prediction.river_water_quality_dataset.variable_trends`
  GROUP BY
    Year, Period, Period_Order,
    Country, River, contamination_level
),

totals AS (
  SELECT
    period_type,
    Year,
    Month,
    Month_Number,
    Period,
    Period_Order,
    Country,
    River,
    SUM(contamination_count) AS total_count
  FROM base
  GROUP BY
    period_type,
    Year,
    Month,
    Month_Number,
    Period,
    Period_Order,
    Country,
    River
)

SELECT
  b.period_type,
  b.Year,
  b.Month,
  b.Month_Number,
  b.Period,
  b.Period_Order,
  b.Country,
  b.River,
  b.contamination_level,
  b.contamination_count,
  ROUND(SAFE_DIVIDE(b.contamination_count, t.total_count) * 100, 2) AS percentage
FROM base b
JOIN totals t
ON b.period_type = t.period_type
AND b.Year = t.Year
AND IFNULL(b.Month, '') = IFNULL(t.Month, '')
AND IFNULL(b.Month_Number, -1) = IFNULL(t.Month_Number, -1)
AND b.Period = t.Period
AND b.Period_Order = t.Period_Order
AND b.Country = t.Country
AND b.River = t.River;