-- Conversion rate by channel
SELECT
    UTM_Source,
    COUNT(*) AS total_touchpoints,
    SUM(Converted) AS total_conversions,
    ROUND(SUM(Converted) * 100.0 / COUNT(*), 2) AS conversion_rate
FROM fact_marketing
GROUP BY UTM_Source
ORDER BY conversion_rate DESC;-- Overall conversion rate
SELECT
    COUNT(*) AS total_touchpoints,
    SUM(Converted) AS total_conversions,
    ROUND(
        SUM(Converted) * 100.0 / COUNT(*), 2
    ) AS overall_conversion_rate
FROM fact_marketing;-- Overall conversion rate
SELECT
    COUNT(*) AS total_touchpoints,
    SUM(Converted) AS total_conversions,
    ROUND(
        SUM(Converted) * 100.0 / COUNT(*), 2
    ) AS overall_conversion_rate
FROM fact_marketing;