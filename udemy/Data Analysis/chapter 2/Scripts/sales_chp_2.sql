
use [Chapter 2 - Sales ]

-- show me all customers living in a particular country. 
select c.AddressLine1,c.LastName,
	   c.EmailAddress,
	   c.MaritalStatus as Total from Customer as c
where c.GeographyKey in 
	   (select g.GeographyKey from Geography as g
	    where g.CountryRegionName like 'german%')
group by c.MaritalStatus,c.LastName,
		c.AddressLine1,c.EmailAddress
-- show all customers living in a specific country
-- who are singles.
select count(c.MaritalStatus) as Total 
from Customer as c
where c.GeographyKey in 
	   (select g.GeographyKey from Geography as g
	    where g.CountryRegionName like 'german%'
		and c.MaritalStatus = 'S')
group by c.MaritalStatus

-- Show details for the following: <param>CountryRegionName</param>
--								   <param>MaritalStatus</param>
-- 	Details of all Customers with a 'Married' status from a specific Country
select c.CustomerKey, c.AddressLine1,c.LastName,
       c.EmailAddress,
	   (select count(os.Customerkey) from OnlineSales as os
		     where os.CustomerKey = c.Customerkey) as Total_Orders,
	   ster.SalesTerritoryRegion, saltyp.SaleTypeName 
	   from Customer as c
inner join OnlineSales as osal on c.CustomerKey = osal.CustomerKey
inner join SalesTerritory as ster on osal.SalesTerritoryKey = ster.SalesTerritoryKey
inner join OnlineSalesType as osaltyp on osal.SalesOrderNumber = osaltyp.SalesOrderNumber
inner join SaleType as saltyp on osaltyp.SaleTypeKey = saltyp.SaleTypeKey
where c.GeographyKey in 
	   (select g.GeographyKey from Geography as g
	    where g.CountryRegionName like 'german%'
		and c.MaritalStatus = 'S')
group by c.Customerkey,c.AddressLine1,
	     c.LastName,c.EmailAddress,
		 ster.SalesTerritoryRegion, saltyp.SaleTypeName
order by Total_Orders desc

-- Show details for the following: <param>Customerkey & SaletypeKey</param>
--			a specific Customer with total orders placed for a specific Sales type
select c.CustomerKey,saltyp.SaleTypeName,saltyp.SaleTypeKey,
	   (select count(os.Customerkey) from OnlineSales as os
		where os.CustomerKey = c.Customerkey) as Total_Orders,
		c.AddressLine1,c.LastName
from Customer as c
inner join OnlineSales as osal on c.CustomerKey = osal.CustomerKey
inner join OnlineSalesType as osaltyp on osal.SalesOrderNumber = osaltyp.SalesOrderNumber
inner join SaleType as saltyp on osaltyp.SaleTypeKey = saltyp.SaleTypeKey
where c.CustomerKey = 11237 and saltyp.SaleTypeKey = 2
group by c.CustomerKey,saltyp.SaleTypeName,
		 saltyp.SaleTypeKey,c.AddressLine1,c.LastName





