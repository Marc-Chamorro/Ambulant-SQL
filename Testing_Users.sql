--Table Connection
create table Users (
  ID int,
  LastName varchar(255),
  FirstName varchar(255),
  Email varchar(255),
  UserPassword varchar(255) 
);

--Primary key this column
alter table Users add primary key (ID)

--Create new column into table WITH NOT NULL ID and automatically int that is being autoupdated
alter table Users add col3 int NOT NULL identity(1,1)

--Remove the old id
alter table Users drop column ID

--Rename the old column into the new one
exec sp_rename 'Users.col1', 'ID', 'column'

--Query Table
select * from Users

--Insert Data
INSERT Users (LastName, FirstName, Email, UserPassword) VALUES ('Chamorro', 'Marc', 'marc.chamorro@sarria.salesians.cat', '12345aA');

--Create Procedure to add users
create procedure Users_SignUp(
 
  @lastName varchar(255),
  @firstName varchar(255),
  @email varchar(255),
  @userPassword varchar(255) 
)
as
begin

insert into Users (LastName, FirstName, Email, UserPassword)
values
(
 
  @lastName,
  @firstName,
  @email,
  @userPassword 
)

end 

go

--Create Procedure to list all users
create procedure Users_List
as
begin

select * from Users
end

go

--Delete Procedure
DROP PROCEDURE [Users_SignUp];  
GO  

--Execute Procedure
execute Users_List

--To check the PK of the specific table
select OBJECT_NAME(OBJECT_ID) AS NameofConstraint
FROM sys.objects
where OBJECT_NAME(parent_object_id)='Users'
and type_desc LIKE '%CONSTRAINT'

--Delete a Constraint Name
alter table Persion drop CONSTRAINT <constraint_name>