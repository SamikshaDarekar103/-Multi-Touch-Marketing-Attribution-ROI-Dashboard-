-- Combined Attribution Comparison
-- All three models side by side
WITH first_touch AS (
    SELECT User_ID, UTM_Source,
        ROW_NUMBER() OVER (
            PARTITION BY User_ID 
            ORDER BY Timestamp_Raw ASC
        ) AS rn
    FROM fact_marketing
),
last_touch AS (
    SELECT User_ID, UTM_Source,
        ROW_NUMBER() OVER (
            PARTITION BY User_ID 
            ORDER BY Timestamp_Raw DESC
        ) AS rn
    FROM fact_marketing
    WHERE Converted = 1
),
journeys AS (
    SELECT User_ID, UTM_Source,
        COUNT(*) OVER (
            PARTITION BY User_ID
        ) AS total_touchpoints
    FROM fact_marketing
),
ft AS (
    SELECT UTM_Source, 
        COUNT(*) AS first_touch_count
    FROM first_touch WHERE rn = 1 
    GROUP BY UTM_Source
),
lt AS (
    SELECT UTM_Source, 
        COUNT(*) AS last_touch_count
    FROM last_touch WHERE rn = 1 
    GROUP BY UTM_Source
),
lin AS (
    SELECT UTM_Source, 
        ROUND(SUM(1.0/total_touchpoints), 2) 
            AS linear_credit
    FROM journeys 
    GROUP BY UTM_Source
)
SELECT 
    COALESCE(ft.UTM_Source, lt.UTM_Source, 
             lin.UTM_Source) AS UTM_Source,
    COALESCE(ft.first_touch_count, 0) 
        AS first_touch_count,
    COALESCE(lt.last_touch_count, 0) 
        AS last_touch_count,
    COALESCE(lin.linear_credit, 0) 
        AS linear_credit
FROM ft
FULL OUTER JOIN lt 
    ON ft.UTM_Source = lt.UTM_Source
FULL OUTER JOIN lin 
    ON ft.UTM_Source = lin.UTM_Source
ORDER BY linear_credit DESC;-- Linear Attribution
-- Splits credit equally across 
-- every touchpoint per user
WITH journeys AS (
    SELECT 
        User_ID, 
        UTM_Source,
        COUNT(*) OVER (
            PARTITION BY User_ID
        ) AS total_touchpoints
    FROM fact_marketing
)
SELECT 
    UTM_Source, 
    ROUND(
        SUM(1.0/total_touchpoints), 2
    ) AS linear_attribution_credit,
    ROUND(
        SUM(1.0/total_touchpoints) * 100.0 / 
        SUM(SUM(1.0/total_touchpoints)) OVER(), 2
    ) AS percentage_of_credit
FROM journeys
GROUP BY UTM_Source 
ORDER BY linear_attribution_credit DESC;-- Last-Touch Attribution
-- Gives 100% credit to the LAST 
-- touchpoint before conversion
WITH last_touch AS (
    SELECT 
        User_ID, 
        UTM_Source,
        ROW_NUMBER() OVER (
            PARTITION BY User_ID 
            ORDER BY Timestamp_Raw DESC
        ) AS rn
    FROM fact_marketing
    WHERE Converted = 1
)
SELECT 
    UTM_Source, 
    COUNT(*) AS last_touch_count,
    ROUND(
        COUNT(*) * 100.0 / 
        SUM(COUNT(*)) OVER(), 2
    ) AS percentage_of_conversions
FROM last_touch 
WHERE rn = 1
GROUP BY UTM_Source 
ORDER BY last_touch_count DESC;-- First-Touch Attribution
-- Gives 100% credit to the FIRST 
-- touchpoint per user
WITH first_touch AS (
    SELECT 
        User_ID, 
        UTM_Source,
        ROW_NUMBER() OVER (
            PARTITION BY User_ID 
            ORDER BY Timestamp_Raw ASC
        ) AS rn
    FROM fact_marketing
)
SELECT 
    UTM_Source, 
    COUNT(*) AS first_touch_count,
    ROUND(
        COUNT(*) * 100.0 / 
        SUM(COUNT(*)) OVER(), 2
    ) AS percentage_of_users
FROM first_touch 
WHERE rn = 1
GROUP BY UTM_Source 
ORDER BY first_touch_count DESC;-- ============================================
-- ATTRIBUTION ANALYSIS
-- Multi-Touch Marketing Attribution Project
-- ============================================

-- Map every user journey step by step
SELECT
    User_ID,
    Timestamp_Raw,
    UTM_Source,
    Campaign,
    Converted,
    ROW_NUMBER() OVER (
        PARTITION BY User_ID 
        ORDER BY Timestamp_Raw
    ) AS step_number,
    COUNT(*) OVER (
        PARTITION BY User_ID
    ) AS total_touchpoints
FROM fact_marketing
ORDER BY User_ID, Timestamp_Raw


-- ============================================
-- KEY FINDINGS:
-- First-Touch: identifies awareness channels
-- Last-Touch: identifies conversion channels  
-- Linear: fairly distributes credit across 
--          all touchpoints in the journey
-- Run each model separately then use the
-- combined query for side-by-side comparison
-- ============================================