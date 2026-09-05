CREATE OR REPLACE TABLE `river-water-quality-prediction.river_water_quality_dataset.processed_river_water_quality` AS

SELECT *,

  SAFE_DIVIDE((nir - red), (nir + red + 1e-6)) AS NDVI,

  SAFE_DIVIDE((green - nir), (green + nir + 1e-6)) AS NDWI,

  SAFE_DIVIDE((green - swir16), (green + swir16 + 1e-6)) AS MNDWI,

  SAFE_DIVIDE((swir16 - nir), (swir16 + nir + 1e-6)) AS NDBI,

  SAFE_DIVIDE((nir - swir16), (nir + swir16 + 1e-6)) AS NDMI,

  SAFE_DIVIDE((red - green), (red + green + 1e-6)) AS NDTI

FROM `river-water-quality-prediction.river_water_quality_dataset.cleaned_river_water_quality`;
