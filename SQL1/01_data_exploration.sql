---- Data quality check - null values
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN User_ID IS NULL THEN 1 ELSE 0 END) AS null_user_id,
    SUM(CASE WHEN UTM_Source IS NULL THEN 1 ELSE 0 END) AS null_utm_source
FROM fact_marketing; Channel and campaign breakdown
SELECT 
    UTM_Source,
    COUNT(*) AS total_touchpoints,
    COUNT(DISTINCT User_ID) AS unique_users
FROM fact_marketing
GROUP BY UTM_Source
ORDER BY total_touchpoints DESC;-- Date range check
SELECT 
    MIN(Timestamp_Raw) AS earliest_touchpoint,
    MAX(Timestamp_Raw) AS latest_touchpoint
FROM fact_marketing;-- ============================================
-- DATA EXPLORATION
-- Multi-Touch Marketing Attribution Project
-- ============================================

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT User_ID) AS unique_users,
    COUNT(DISTINCT UTM_Source) AS unique_channels,
    COUNT(DISTINCT Campaign) AS unique_campaigns
FROM fact_marketing;