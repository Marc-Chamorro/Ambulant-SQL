--Create Procedures

--Tags

--Persons
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