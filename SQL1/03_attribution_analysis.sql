-- Last-Touch Attribution
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
LIMIT 50;