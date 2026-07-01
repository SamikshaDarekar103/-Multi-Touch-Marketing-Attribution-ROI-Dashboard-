SELECT
    UTM_Source,
    COUNT(User_ID) AS Total_Users,
    SUM(Clicks) AS Total_Clicks,
    SUM(Impressions) AS Total_Impressions,
    SUM(Converted) AS Total_Conversions,
    SUM(Revenue) AS Total_Revenue,
    SUM(Ad_Spend) AS Total_Ad_Spend,
    
    ROUND(
        (SUM(Converted) * 100.0 / COUNT(User_ID)),
        2
    ) AS Conversion_Rate_Percentage,

    ROUND(
        ((SUM(Revenue) - SUM(Ad_Spend))
        / NULLIF(SUM(Ad_Spend),0)) * 100,
        2
    ) AS ROI_Percentage

FROM marketing_data
GROUP BY UTM_Source
ORDER BY Total_Revenue DESC;

SELECT
    UTM_Source,
    SUM(Revenue) AS Revenue
FROM marketing_data
GROUP BY UTM_Source
ORDER BY Revenue DESC;

SELECT
    UTM_Source,
    SUM(Converted) AS Conversions
FROM marketing_data
GROUP BY UTM_Source
ORDER BY Conversions DESC;