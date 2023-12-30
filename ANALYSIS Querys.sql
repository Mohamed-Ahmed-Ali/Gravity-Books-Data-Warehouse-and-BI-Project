-- Order Price
Select DimOrderLines.Order_ID, SUM(Price) from DimOrderLines
group by Order_ID 

-- Shipping_Cost Per Order
Select fo.Order_ID, SUM(ds.Cost_Shipping) as [Shipping_Cost_Order]  From FactOrders as fo
join DimShipping as ds on fo.Shipping_Method_SK = ds.Shipping_Method_SK
group by Order_ID 
Order By [Shipping_Cost_Order] DESC

-- Shipping_Cost & Price Per Order

Select fo.Order_ID, SUM(Price) as [Price_Order], SUM(ds.Cost_Shipping) as [Shipping_Cost_Order]  From FactOrders as fo
join DimShipping as ds on fo.Shipping_Method_SK = ds.Shipping_Method_SK
join DimOrderLines as do on do.Order_ID = fo.Order_ID
group by fo.Order_ID 

-- Bilil
SELECT
    Order_ID,
    Price_Order,
    Shipping_Cost_Order,
    (Price_Order + Shipping_Cost_Order) AS Bill
FROM
(
    SELECT
        fo.Order_ID,
        SUM(Price) AS Price_Order,
        SUM(ds.Cost_Shipping) AS Shipping_Cost_Order
    FROM
        FactOrders AS fo
    JOIN
        DimShipping AS ds ON fo.Shipping_Method_SK = ds.Shipping_Method_SK
    JOIN
        DimOrderLines AS do ON do.Order_ID = fo.Order_ID
    GROUP BY
        fo.Order_ID
) AS subquery


-- Number Of Lines Per Order
Select DimOrderLines.Order_ID, Count(DimOrderLines.Line_ID) as Lines_Number from DimOrderLines
group by Order_ID 
Order By Lines_Number Desc

-- Number of Book Per Order
Select DimOrderLines.Order_ID, Count(DimOrderLines.Book_SK) as Books_Number from DimOrderLines
group by Order_ID 
Order By Books_Number DESC

-- Top Selling Book

Select db.Title, COunt(do.Order_ID) [Orders Per Book]  From DimOrderLines as do
join DimBook as db on do.Book_SK = db.Book_SK
group by Title
Order By [Orders Per Book] Desc

-- Top Selling Publisher

Select db.Publisher_Name, COunt(do.Order_ID) [Orders Per Book]  From DimOrderLines as do
join DimBook as db on do.Book_SK = db.Book_SK
group by Publisher_Name
Order By [Orders Per Book] Desc

-- Number Of Orders per Auther 
Select da.Author_Name, Count(do.Order_ID) as [Order Per Author] from DimOrderLines as do
join DimBook as db on do.Book_SK = db.Book_SK
join DimAuthor as da on db.Author_SK = db.Author_SK
group by da.Author_Name
HAVING da.Author_Name IS NOT NULL
Order By [Order Per Author] DESC

-- Top Customers
SELECT
    CONCAT(dc.First_Name, ' ', dc.Last_Name) AS [Full Name],
    COUNT(df.Order_ID) AS [Orders Per Book]
FROM
    FactOrders AS df
JOIN
    DimCustomer AS dc ON df.Customer_SK = dc.Customer_SK
GROUP BY
    CONCAT(dc.First_Name, ' ', dc.Last_Name)
ORDER BY
    [Orders Per Book] DESC



