# shipment_sql_analysis
# Advanced SQL Practice Project

## Overview

This project demonstrates advanced SQL techniques using a shipment dataset. The dataset includes information about orders, customers, and products. The project involves creating a relational database, inserting data, and executing advanced SQL queries to extract meaningful insights.

## Project Structure

├── data/
│   └── original_data.csv       # Original dataset
├── scripts/
│   └── create_tables.sql       # SQL script to create tables
│   └── insert_data.sql         # SQL script to insert data
│   └── queries.sql             # SQL script with advanced SQL queries
├── README.md                   # Project description and documentation
└── LICENSE                     # License information https://catalog.data.gov/dataset/?res_format=CSV

## Dataset

The dataset includes the following columns:
- `RowID`: A unique identifier for each row in the dataset.
- `OrderID`: A unique identifier for each order.
- `OrderDate`: The date when the order was placed.
- `ShipDate`: The date when the order was shipped.
- `ShipMode`: The mode of shipping used for the order.
- `CustomerID`: A unique identifier for each customer.
- `CustomerName`: The name of the customer.
- `Segment`: The market segment to which the customer belongs.
- `Country`: The country where the order was shipped.
- `City`: The city where the order was shipped.
- `State`: The state where the order was shipped.
- `PostalCode`: The postal code of the shipping location.
- `Region`: The region where the order was shipped.
- `ProductID`: A unique identifier for each product.
- `Category`: The category to which the product belongs.
- `SubCategory`: The sub-category to which the product belongs.
- `ProductName`: The name of the product.
- `Sales`: The sales amount of the product in the order.
- `Quantity`: The quantity of the product ordered.
- `Discount`: The discount applied to the product.
- `Profit`: The profit generated from the product in the order.

## SQL Scripts

### Create Tables

The `create_tables.sql` script creates three tables: `Customers`, `Orders`, and `Products`.

```sql
-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    Segment VARCHAR(255),
    Country VARCHAR(255),
    City VARCHAR(255),
    State VARCHAR(255),
    PostalCode VARCHAR(255),
    Region VARCHAR(255)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    ShipDate DATE,
    ShipMode VARCHAR(255),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    OrderID INT,
    Category VARCHAR(255),
    SubCategory VARCHAR(255),
    ProductName VARCHAR(255),
    Sales DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(4, 2),
    Profit DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
