use Triggerdemo

CREATE TABLE TriggerDemo_NewParent
(
   ID INT IDENTITY (1,1) PRIMARY KEY,
   Emp_First_name VARCHAR (50),
   Emp_Last_name VARCHAR (50),
   Emp_Salary INT 
  )
GO


CREATE TABLE TriggerDemo_InsteadParent
(
   ID INT IDENTITY (1,1) PRIMARY KEY,
   ParentID INT,
   PerformedAction VARCHAR (50),
  )
GO

alter table TriggerDemo_InsteadParent
add ActionDate DATETIME NOT NULL DEFAULT (GETDATE())

GO
CREATE TRIGGER InsteadOfDeleteTrigger
ON TriggerDemo_NewParent
INSTEAD OF DELETE
AS
INSERT INTO TriggerDemo_InsteadParent VALUES ((SELECT TOP 1  inserted.ID FROM inserted), 'Trying to Delete an existing ID', GETDATE())
GO

CREATE TRIGGER InsteadOfUpdateTrigger
ON TriggerDemo_NewParent
INSTEAD OF UPDATE
AS
INSERT INTO TriggerDemo_InsteadParent VALUES ((SELECT TOP 1  inserted.ID FROM inserted), 'Trying to Update an existing ID', GETDATE())
GO

CREATE TRIGGER InsteadOfInsertTrigger
ON TriggerDemo_NewParent
INSTEAD OF INSERT
AS
INSERT INTO TriggerDemo_InsteadParent VALUES ((SELECT TOP 1  inserted.ID FROM inserted), 'Trying to Insert new ID', GETDATE())
GO

select * from TriggerDemo_NewParent
select * from TriggerDemo_InsteadParent
insert into TriggerDemo_NewParent
values ('abhijit', 'chitnis', 2200); 

select pers.firstname, pers.lastname from Person.Person as pers
where exists (select 1 from Sales.SalesPerson as salper
			  where pers.BusinessEntityID = salper.BusinessEntityID)
order by pers.firstname;






