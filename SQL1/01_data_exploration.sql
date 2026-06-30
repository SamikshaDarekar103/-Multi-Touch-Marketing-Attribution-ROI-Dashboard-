-- ============================================
-- DATA EXPLORATION
-- Multi-Touch Marketing Attribution Project
-- ============================================

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT User_ID) AS unique_users,
    COUNT(DISTINCT UTM_Source) AS unique_channels,
    COUNT(DISTINCT Campaign) AS unique_campaigns
FROM fact_marketing;