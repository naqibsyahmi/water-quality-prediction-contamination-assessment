CREATE OR REPLACE TABLE `river-water-quality-prediction.river_water_quality_dataset.mapped_river_water_quality` AS

SELECT *,

  CASE

    -- Hong Kong rivers
    WHEN River IN (
      'Siu Lek Yuen Nullah',
      'Tin Shui Wai Nullah',
      'River Beas',
      'River Ganges',
      'Tung Chung River',
      'Kam Tin River',
      'Lam Tsuen River',
      'Ngau Hom Sha Stream',
      'River Indus',
      'Tseng Lan Shue Stream',
      'Kai Tak River',
      'Tin Sum Nullah',
      'Sheung Pak Nai Stream',
      'Shan Liu Stream',
      'Yuen Long Nullah',
      'Tai Po River',
      'Ho Chung River',
      'Tai Wai Nullah',
      'Sha Kok Mei Stream',
      'Tung Tze Stream',
      'Tuen Mun River',
      'Shing Mun Main Channel',
      "Pai Min Kok (Anglers') Stream",
      'Tai Shui Hang Stream',
      'Kau Wa Keng Stream',
      'Tsang Kok Stream',
      'Tai Po Kau Stream',
      'Fairview Park Nullah',
      'Pak Nai Stream',
      'Kwun Yam Shan Stream',
      'Ha Pak Nai Stream',
      'Tai Chung Hau Stream',
      'Sam Dip Tam Stream',
      'Fo Tan Nullah',
      'Mui Wo River'
    ) THEN 'Hong Kong'

    -- England rivers
    WHEN River IN (
      'Thame at Wheatley',
      'Coln at Whelford',
      'Ock at Abingdon',
      'Pang at Tidmarsh',
      'Thames at Sonning',
      'Lodden at Charvil',
      'The Cut at Paley Street',
      'Thames at Runnymede',
      'Wye at Bourne End',
      'Thames at Wallingford',
      'Thames at Hannington',
      'Ray at Islip',
      'Kennet at Woolhampton',
      'Enborne at Brimpton',
      'Jubilee River at Pococks Bridge',
      'Thames at Goring',
      'Colne at Staines',
      'Thames at Taplow',
      'Cherwell at Hampton Poyle',
      'Evenlode at Cassington Mill',
      'Thames at Swinford',
      'Thames at Newbridge',
      'Windrush at Newbridge',
      'Leach at Lechlade',
      'Cole at Lynt Bridge'
    ) THEN 'England'

    ELSE NULL

  END AS Country

FROM `river-water-quality-prediction.river_water_quality_dataset.raw_river_water_quality`;