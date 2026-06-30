-- Date range check
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