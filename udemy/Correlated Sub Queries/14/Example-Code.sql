USE AdventureWorks2016CTP3

-- Using IN with out Subqueries
-- Select all sales orders from sales perssons who had bonuses
-- over 5000.
SELECT SalesOrderID
      ,OrderDate
      ,AccountNumber
      ,CustomerID
      ,SalesPersonID
      ,TotalDue
  FROM Sales.SalesOrderHeader
  WHERE SalesPersonID IN (279, 286, 289)


-- Using IN with a Subquery.
-- Same a previous query, execpt, now we don't HARDCODE the
-- SalesPersonID's.  We us a subquery to "pump" them into
-- the IN operator.
SELECT SalesOrderID
      ,OrderDate
      ,AccountNumber
      ,CustomerID
      ,SalesPersonID
      ,TotalDue
  FROM Sales.SalesOrderHeader
  WHERE SalesPersonID IN (SELECT BusinessEntityID
                          FROM   Sales.SalesPerson
                          WHERE  Bonus > 5000
                         )


--Correlated Subquery in IN clause!
--Return SalesOrders where the SalesPerson has Year To Date Sales greater than 3,000,000
--This is a correlated subquery -- We make sure the SalesPerson in the SalesOrderHeader and
--is the same as in the SalesPerson record.
SELECT SalesOrderID,
       RevisionNumber,
       OrderDate
FROM   Sales.SalesOrderHeader
WHERE  SalesPersonID IN (SELECT SalesPerson.BusinessEntityID
                         FROM   sales.SalesPerson
                         WHERE  SalesYTD > 3000000
                            AND SalesOrderHeader.SalesPersonID = Sales.SalesPerson.BusinessEntityID)


--Not IN
--Correlated Subquery in IN clause!
--Return SalesOrders where the SalesPerson does not have Year To Date Sales greater than 3,000,000
--This is a correlated subquery -- We make sure the SalesPerson in the SalesOrderHeader and
--is the same as in the SalesPerson record.
SELECT SalesOrderID,
       RevisionNumber,
       OrderDate
FROM   Sales.SalesOrderHeader
WHERE  SalesPersonID NOT IN (SELECT SalesPerson.BusinessEntityID
               FROM   sales.SalesPerson
               WHERE  SalesYTD > 3000000
                      AND SalesOrderHeader.SalesPersonID = Sales.SalesPerson.BusinessEntityID)


--IN and NULL
-- What happens when you're looking for an ID
-- IN NULL?
-- You may think it would bring back every ID in the table, but
-- NULL is tricky, it pretty much invalidates any comparisons.
-- In this case no rows are returned.
SELECT SalesOrderID,
       RevisionNumber,
       OrderDate
FROM   Sales.SalesOrderHeader
WHERE  SalesOrderID  IN (SELECT NULL)
