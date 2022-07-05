create table Favourites (
  ID int,
  ID_User int,
  ID_Local int,

);

create table Type (
  ID int,
  Name varchar(255),
  Tag varchar(255)
);

INSERT Type (ID, Name, Tag) VALUES (1, 'Food', 'food');
Insert Type (ID) VALUES (1);
Delete from type where name = 'Food';

select * from Type

end

go

create procedure Type_List
as
begin

select * from Type
end

go

execute Type_List