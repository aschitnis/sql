
use [Chapter 3 - Sales (Keyed) ]

-- Alle Zulieferern mit denen zugehörigen Produkten
 select sup.Name,
		prdsup.StandardPrice,
		prd.ProductName
 from 
	supplier sup
	inner join productsupplier prdsup on sup.SupplierKey = prdsup.SupplierKey
	inner join Product prd on prdsup.ProductKey = prd.ProductKey

-- Anzahl der Produkte pro Zulieferer
select  sup.SupplierKey, sup.Name Supplier_Name,
		COUNT(prdsup.ProductKey) Products
from 
	Supplier sup
	inner join productsupplier prdsup on sup.SupplierKey = prdsup.SupplierKey
group by prdsup.ProductKey,sup.Name,sup.SupplierKey
order by Products desc


-- Summe der bestellten Produktentypen, die eine bestimmte Kunde online bestellt hat.
-- Information zum Kunde und zu den Produkten wird angezeigt.   
select	c.CustomerKey,c.FirstName,c.LastName,c.GeographyKey, 
		geo.City,osl.ProductKey,prd.ProductName,
	    COUNT(osl.ProductKey) Produkteanzahl 
	from Customer c
		inner join OnlineSales osl on c.CustomerKey = osl.CustomerKey
		inner join Geography geo on c.GeographyKey = geo.GeographyKey
		inner join Product prd on prd.ProductKey = osl.ProductKey
	where c.CustomerKey = 11262
GROUP BY osl.ProductKey,c.CustomerKey,c.FirstName,c.LastName,c.GeographyKey,
		 geo.City, prd.ProductName
order by osl.ProductKey asc

---
select c.CustomerKey,c.LastName,c.Gender, 
	   c.MaritalStatus from Customer c
	where c.GeographyKey 
			in ( select GeographyKey from geography
					where City like 'San%'
			   )
order by c.Gender

-- customers living in a certain city<parameter> grouped together 
-- by their marital-status  
select  
	Count(c.MaritalStatus) Kunden, 
	c.MaritalStatus, 
	c.Gender 
from Customer c
	where c.GeographyKey 
		in ( select GeographyKey from geography
				where City like 'San%' 
			)
group by c.MaritalStatus, c.Gender




select sub.ProductKey,sub.ProductName,sub.Name Zulieferer,
	   sub.MinOrderQty,sub.StandardPrice
FROM 
	(
	 select sup.Name,prd.ProductKey,
			prdsup.StandardPrice,
			prdsup.MinOrderQty,		
			prd.ProductName
	 from 
		supplier sup
		inner join productsupplier prdsup on sup.SupplierKey = prdsup.SupplierKey
		inner join Product prd on prdsup.ProductKey = prd.ProductKey 
	) sub
WHERE sub.MinOrderQty > 110 

/*
CREATE TABLE TriggerDemo_Parent
(
   ID INT IDENTITY (1,1) PRIMARY KEY,
   Emp_First_name VARCHAR (50),
   Emp_Last_name VARCHAR (50),
   Emp_Salary INT 
  )
GO

CREATE TABLE TriggerDemo_History
(
   ID INT IDENTITY (1,1) PRIMARY KEY,
   ParentID INT,
   PerformedAction VARCHAR (50),
  )
GO
*/
--INSERT INTO TriggerDemo_Parent VALUES ('Abhijit','Chitnis',2200)
--update Triggerdemo_parent set emp_salary = 556 where id = 1


--DELETE FROM Triggerdemo_parent where ID = 2

--select * from Triggerdemo_parent;
--select * from Triggerdemo_history