--Total Net Profit by Month:
SELECT [MONTH], SUM([Net profit]) AS Total_Net_Profit
FROM [FSP Supply Chain portfolio ].dbo.[FSP DELIVERY TREND 2023]
GROUP BY [MONTH]
ORDER BY [MONTH];

--Average Delivery Charge by Month:
SELECT [MONTH], AVG([Delivery charge]) AS Avg_Delivery_Charge
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY [MONTH]
ORDER BY [MONTH];

--Average Delivery Cost by Month:
SELECT [MONTH], AVG([Delivery cost]) AS Avg_Delivery_cost
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY [MONTH]
ORDER BY [MONTH];

--Net Profit Margin by Month:
SELECT [MONTH], 
       (SUM([Net profit]) / SUM([Delivery charge] + [Delivery cost])) * 100 AS Net_Profit_Margin
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY [MONTH]
ORDER BY [MONTH];

--Total Purchase Orders by Month:
SELECT [MONTH], COUNT(DISTINCT [Purchase Order]) AS Total_Purchase_Orders
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY [MONTH]
ORDER BY [MONTH];

--Total Sales by Month:
SELECT [MONTH], 
SUM([Net profit] + [Delivery charge] + [Delivery cost]) AS Total_Sales
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY [MONTH]
ORDER BY [MONTH];

--Top 3 Companies by Net Profit in Each Month:
SELECT Month, [Company Name], Total_Net_Profit
FROM (
    SELECT Month, [Company Name], SUM([Net profit]) AS Total_Net_Profit,
           ROW_NUMBER() OVER (PARTITION BY month, [Company Name] ORDER BY SUM([Net profit]) DESC) AS Company_Rank
    FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
    WHERE Month LIKE '%May%' OR month LIKE '%Jun%' OR month LIKE '%Aug%' OR month LIKE '%Sep%' OR month LIKE '%Oct%' OR month LIKE '%Nov%' OR month LIKE '%Dec%'
    GROUP BY month, [Company Name]
) AS RankedCompanies
WHERE Company_Rank <= 3
ORDER BY Month, Total_Net_Profit DESC;


--Average Delivery Cost per Company:
SELECT [Company Name], AVG(DISTINCT [Delivery cost]) * 100 / 12 AS Avg_Delivery_Cost
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY MONTH, [Company Name]
ORDER BY Avg_Delivery_Cost DESC;

--FSP top 15 Average Delivery Cost 
SELECT TOP 15 [Company Name], AVG(DISTINCT [Delivery cost]) AS Avg_Delivery_Cost
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY MONTH, [Company Name]
ORDER BY Avg_Delivery_Cost DESC;

--Highest Net profit by Sales Man: 
SELECT [Sale name], SUM([Net profit]) AS total_net_profit
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
WHERE [Sale name] LIKE '%Angus%'
    OR [Sale name] LIKE '%Eric Lin%'
    OR [Sale name] LIKE '%Kevin%'
GROUP BY [Sale name]
ORDER BY total_net_profit DESC;

--Net Profit Comparison between Angus, Eric Lin and Kevin by Month:
SELECT Month,
       SUM(CASE WHEN [sale name] = 'Angus' THEN [Net profit] ELSE 0 END) AS Angus_Net_Profit,
       SUM(CASE WHEN [sale name] = 'Eric Lin' THEN [Net profit] ELSE 0 END) AS Eric_Lin_Net_Profit,
       SUM(CASE WHEN [sale name] = 'Kevin' THEN [Net profit] ELSE 0 END) AS Kevin_Net_Profit
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY MONTH
ORDER BY MONTH;

--Total Net profit by Shipper also ranking the top 10 shipper
SELECT TOP 15 shipper,
       SUM([Net Profit]) AS Total_Net_Profit
FROM [FSP Supply Chain portfolio].dbo.[FSP DELIVERY TREND 2023]
GROUP BY shipper
ORDER BY Total_Net_Profit DESC;














