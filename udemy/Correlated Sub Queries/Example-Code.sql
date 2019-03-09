
--Subquery
SELECT SalesOrderID,
       OrderDate,
       TotalDue,
       (SELECT COUNT(SalesOrderDetailID)
        FROM   Sales.SalesOrderDetail
        WHERE  SalesOrderID = SO.SalesOrderID) as LineCount
FROM  Sales.SalesOrderHeader SO 

--Inner Join
SELECT   SO.SalesOrderID,
         OrderDate,
         TotalDue,
         COUNT(SOD.SalesOrderDetailID) as LineCount
FROM     Sales.SalesOrderHeader SO
         INNER JOIN Sales.SalesOrderDetail SOD
         ON SOD.SalesOrderID = SO.SalesOrderID
GROUP BY SO.SalesOrderID, OrderDate, TotalDue 

