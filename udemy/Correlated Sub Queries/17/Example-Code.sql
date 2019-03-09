USE AdventureWorks2016CTP3;

--Correlated Subquery in Having Clause
SELECT    JobTitle,
          MaritalStatus,
          AVG(VacationHours)
 FROM     HumanResources.Employee AS E
 GROUP BY JobTitle, MaritalStatus
 HAVING   AVG(VacationHours) > 
          (SELECT AVG(VacationHours)
             FROM   HumanResources.Employee
            WHERE HumanResources.Employee. MaritalStatus = E.MaritalStatus)
