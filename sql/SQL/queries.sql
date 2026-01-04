-- Superstore SQL Analysis
-- Dataset loaded into MySQL using Python (ETL flow)


USE superstore_db;

-- 1. Overall business performance
SELECT 
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore;


-- 2. Category-wise sales and profit
SELECT 
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_profit DESC;


-- 3. Loss-making sub-categories
SELECT 
    `Sub-Category`,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Sub-Category`
HAVING total_profit < 0
ORDER BY total_profit;


-- 4. Region-wise profitability
SELECT 
    Region,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY Region
ORDER BY total_profit DESC;


-- 5. Discount impact on profit
SELECT 
    Discount,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM superstore
GROUP BY Discount
ORDER BY Discount;


-- 6. Year-wise sales trend
SELECT 
    YEAR(`Order Date`) AS order_year,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY order_year
ORDER BY order_year;


-- 7. Average shipping days by ship mode
SELECT 
    `Ship Mode`,
    AVG(DATEDIFF(`Ship Date`, `Order Date`)) AS avg_shipping_days
FROM superstore
GROUP BY `Ship Mode`;


-- 8. Top 5 profitable products
SELECT 
    `Product Name`,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Product Name`
ORDER BY total_profit DESC
LIMIT 5;


-- 9. Create view for reusable reporting
CREATE VIEW category_summary AS
SELECT 
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY Category;


-- 10. Querying the view
SELECT * FROM category_summary;
