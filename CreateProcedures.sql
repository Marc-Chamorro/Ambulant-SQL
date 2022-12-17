--Create Procedures

------------------------------------------------Login------------------------------------------------

USE [Ambulant]
GO

select password, hash from persons where name LIKE 'Marc'
go

create procedure User_Check_Login(
  @name varchar(255)
)
as
begin

select password, hash from persons
where name LIKE @name

end 

go

execute User_Check_Login 'Marc'
go

------------------------------------------------Persons------------------------------------------------

USE [Ambulant]
GO

select * from persons where name LIKE 'Marc'
go

create procedure User_Creation(

  @name varchar(255),
  @email varchar(255),
  @password varchar(255),
  @hash varchar(255) 
)
as
begin

insert into persons (name, email, password, hash)
values
(
  @name,
  @email,
  @password,
  @hash 
)
end 
go

------------------------------------------------

USE [Ambulant]
GO

select id_persons, name, email from persons
go

create procedure User_List
as
begin

select id_persons, name, email from persons

end 
go

execute User_List

------------------------------------------------

USE [Ambulant]
GO

select name, email from persons
go

create procedure User_Check_Exists(
  @name varchar(255),
  @email varchar(255)
)
as
begin

select name, email from persons
where name LIKE @name
or email LIKE @email

end 

go