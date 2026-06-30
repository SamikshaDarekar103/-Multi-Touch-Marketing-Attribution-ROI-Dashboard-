-- ============================================
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