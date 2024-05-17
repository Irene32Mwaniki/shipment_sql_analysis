USE shipment;
DROP TABLE IF EXISTS shipment_information2; 
CREATE TABLE shipment_information2 (
	RowID SMALLINT Primary KEY,
    OrderID VARCHAR(255),
    OrderDate DATE,
    ShipDate DATE, 
    ShipMode VARCHAR(255),
    CustomerID VARCHAR(255) NOT NULL,
    CustomerName VARCHAR(255) Not NUll, 
    Segment VARCHAR(255), 
    Country VARCHAR(255), 
    City VARCHAR(255), 
    State VARCHAR(255), 
    PostalCode VARCHAR(255), 
    Region VARCHAR(255),
    ProductID VARCHAR(255),
    Category VARCHAR(255),
    SubCategory VARCHAR(255),
    ProductName VARCHAR(255),
    Sales DECIMAL(10,4),
    Quantity INT, 
    Discount DECIMAL(4,2),
    Profit DECIMAL(10,4)
);

INSERT INTO shipment_information2
SELECT *
FROM shipment_information;

-- (1) retrieve all orders where the sales were greater than $1000
SELECT *
FROM shipment_information2 
WHERE sales > 1000;

-- (2) Total profit generated from orders in the 'technology' category 
SELECT SUM(Profit) AS TotalProfit
FROM shipment_information2
WHERE Category = 'technology'; 

-- (3) top 5 customers who made the highest purchases (by total sales) 
SELECT CustomerID, CustomerName, SUM(Sales) AS TotalSales
FROM shipment_information2
GROUP BY CustomerID, CustomerName
ORDER BY TotalSales DESC
LIMIT 5;

-- (4) calculate the average discount percentage for each category 
SELECT DISTINCT category 
FROM shipment_information2; 

SELECT category, AVG(Discount) AS AvgDiscount
FROM shipment_information2
GROUP BY category; 

-- (5) find the numebr of orders placed in each region 
SELECT DISTINCT region
FROM shipment_information2; 

SELECT region, COUNT(orderid) AS NumOrders
FROM shipment_information2
GROUP BY region; 

-- (6) identify the products that have a negative profit margin (profit < 0) 
SELECT ProductName, Profit
FROM shipment_information2
WHERE profit < 0; 

-- (7) list the orders sorted by the order date in descending order 
SELECT *
FROM shipment_information2
ORDER BY orderdate DESC; 

-- (8) calculate the total sales for each year 
SELECT Year(OrderDate) AS Order_Year, SUM(Sales) AS Total_Sales
FROM shipment_information2
GROUP BY 1; 

-- (9) find the top 3 sub-categories with the highest average profit 
SELECT SubCategory, AVG(Profit) AS Avg_Profit
FROM shipment_information2
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3; 

-- (10) retrieve orders where the quantity sold is greate than 10 and the discount is less then 0.1 
SELECT *
FROM shipment_information2
WHERE Quantity > 10 AND Discount < 0.1; 

-- (11) Stored Procedure option for obtaining customer details 
DROP PROCEDURE IF EXISTS GetCustomerDetails; 
DELIMITER $$ 
CREATE PROCEDURE GetCustomerDetails (IN p_customerID varchar(255))
BEGIN 
	SELECT CustomerName, OrderDate, ShipDate, ProductID
    FROM shipment_information2
    WHERE CustomerID = p_customerID;
END $$
DELIMITER ; 

CALL GetCustomerDetails('CG-12520'); 


-- (12) Stored Function to retrieve discounted price 
DELIMITER $$
CREATE FUNCTION CalculateDiscountedPrice (sales DECIMAL (10,4), discount DECIMAL (4,2))
RETURNS Decimal (10,4) 
DETERMINISTIC NO SQL READS SQL DATA
BEGIN 
	DECLARE discountedprice DECIMAL(10,4); 
    SET discountedprice = sales - (sales * discount);
    RETURN discountedprice; 
END $$
DELIMITER ; 

SET @sales = 261.96;  -- to set the product price 
SET @discount = 0.01; -- to set the discount 

SELECT CalculateDiscountedPrice(@sales, @discount) AS discountedprice; 


-- visualization data 
SELECT 
	YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    COUNT(*) NumberofOrders,
    SUM(Sales) As TotalSales
FROM shipment_information2
GROUP BY 1, 2
ORDER BY 1, 2; 