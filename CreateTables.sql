--Creation Order
--tags (empty)
--ratings (empty)
--discounts_model (empty)
--review_images (empty)
--local_prices (empty)
--user (empty)
--local (user, local_prices, discounts_model)
--user_favourites (user, local)
--local_tag (local, tags)
--discounts_historial (user, local)
--local_images (local)
--review_text (local_prices)
--review_text_user_local (local, user, review_text)
--review_images_user_local (local, user, review_images)



--To Use a Random Guid each time, we will be using the following:
--USE EngDB
--GO
--CREATE TABLE EnglishStudents1
--(
--	Id UNIQUEIDENTIFIER PRIMARY KEY default NEWID(),
--	StudentName VARCHAR (50)
--)
--GO
--INSERT INTO EnglishStudents1 VALUES (default,'Shane')
--INSERT INTO EnglishStudents1 VALUES (default,'Jonny')

--SELECT NEWID()

CREATE TABLE tags (
  id_tag UNIQUEIDENTIFIER CONSTRAINT PK_Tags_Id PRIMARY KEY default NEWID(),
  name varchar(255) NOT NULL,
  tag varchar(255) NOT NULL,
  image varchar(255) default NEWID(),

  --image varchar(255) default NEWID(), --generate random name just in case and rename the image
  --as the path is always the same, it can be configured directly and not necessary to hardcode it
)


--INSERT INTO tags VALUES (default,'name here', 'epic tag', 'image_file_name.png')
--select * from tags
--DROP TABLE tags

CREATE TABLE discounts_model (
  id_discounts_model UNIQUEIDENTIFIER CONSTRAINT PK_DiscountsDodel_Id PRIMARY KEY default NEWID(),
  type varchar(255) NOT NULL,
  value int NOT NULL
)

--once the image is loaded as a query, check if the images exist, if so then do anything, if not then delete the register
--also maximum of 10.000 per folder
CREATE TABLE review_images (
  id_review_images UNIQUEIDENTIFIER CONSTRAINT PK_ReviewImages_Id PRIMARY KEY default NEWID(),
  name varchar(255) default NEWID(), --generate random name just in case and rename the image
  path varchar(255) NOT NULL --from the server, if folder doe not existe create it, maximum of 10.000? images per folder, once full create a new one
)

CREATE TABLE shop_prices ( --segons el preu mitja especificat, mostrara uns icones o uns altres $$$
  id_shop_prices UNIQUEIDENTIFIER CONSTRAINT PK_ShopPrices_Id PRIMARY KEY default NEWID(),
  name varchar(255) NOT NULL,
  range_max int NOT NULL, --valor maxim acceptat
  range_min int NOT NULL, --valor minim acceptat
  value int NOT NULL --percentatge respectiu
)

CREATE TABLE ratings ( --tipica estrelles de les reviews a mostrar
  id_rating UNIQUEIDENTIFIER CONSTRAINT PK_Ratings_Id PRIMARY KEY default NEWID(),
  name varchar(255) NOT NULL,
  value int NOT NULL
)

CREATE TABLE persons (
  id_persons UNIQUEIDENTIFIER CONSTRAINT PK_Persons_Id PRIMARY KEY default NEWID(),
  name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  hash varchar(255) NOT NULL,
  latitude decimal(12,8) DEFAULT 0,
  longitude decimal(12,8) DEFAULT 0,
  creation datetime,
  discount int DEFAULT 0 --precalculate before every discount action and once loaded
)

ALTER TABLE persons ADD DEFAULT GETDATE() FOR creation
select * from persons

CREATE TABLE shop (
  id_shop UNIQUEIDENTIFIER CONSTRAINT PK_Shop_Id PRIMARY KEY default NEWID(),
  name varchar(255) NOT NULL,
  description varchar(255) NOT NULL,
  --image
  latitude decimal(12,8) DEFAULT 0,
  longitude decimal(12,8) DEFAULT 0,
  state int DEFAULT 0, --0 false and 1 true depending if open or close
  price UNIQUEIDENTIFIER CONSTRAINT FK_Shop_ShopPrices_ID REFERENCES shop_prices(id_shop_prices), --precalculate once it is opened
  rating UNIQUEIDENTIFIER CONSTRAINT FK_Shop_Ratings_ID REFERENCES ratings(id_rating),
  last_opened datetime,
  owner UNIQUEIDENTIFIER CONSTRAINT FK_Shop_Persons_Id REFERENCES persons(id_persons),
  discount_model UNIQUEIDENTIFIER CONSTRAINT FK_Shop_DiscountsModel_Id REFERENCES discounts_model(id_discounts_model) --precalculate once it is opened
)

CREATE TABLE person_favourites (
  id_person_favourites UNIQUEIDENTIFIER CONSTRAINT PK_PersonFavourites_Id PRIMARY KEY default NEWID(),
  creation datetime,
  id_shop UNIQUEIDENTIFIER CONSTRAINT FK_PersonFavourites_Shop_Id REFERENCES shop(id_shop),
  id_person UNIQUEIDENTIFIER CONSTRAINT FK_PersonFavourites_Persons_Id REFERENCES persons(id_persons)
)

CREATE TABLE shop_tag (
  id_shop_tag UNIQUEIDENTIFIER CONSTRAINT PK_ShopTag_Id PRIMARY KEY default NEWID(),
  id_shop UNIQUEIDENTIFIER CONSTRAINT FK_ShopTag_Shop_Id REFERENCES shop(id_shop),
  id_tag UNIQUEIDENTIFIER CONSTRAINT FK_ShopTag_Tags_Id REFERENCES tags(id_tag)
)

CREATE TABLE discounts_historial (
  id_discounts_historial UNIQUEIDENTIFIER CONSTRAINT PK_DiscountsHistorial_Id PRIMARY KEY default NEWID(),
  creation datetime,
  value int NOT NULL,
  operation int DEFAULT 0, --if its 0 remove, if its 1 acumulate
  id_shop UNIQUEIDENTIFIER CONSTRAINT FK_DiscountsHistorial_Shop_Id REFERENCES shop(id_shop),
  id_person UNIQUEIDENTIFIER CONSTRAINT FK_DiscountsHistorial_Persons_Id REFERENCES persons(id_persons)
)

--once the image is loaded as a query, check if the images exist, if so then do anything, if not then delete the register
CREATE TABLE shop_images (
  id_shop_images UNIQUEIDENTIFIER CONSTRAINT PK_ShopImages_Id PRIMARY KEY default NEWID(),
  name varchar(255) default NEWID(), --generate random name just in case and rename the image
  path varchar(255) NOT NULL, --maximum of 10.000 images per filder (check before storing)
  image_order int DEFAULT 0,
  id_shop UNIQUEIDENTIFIER CONSTRAINT FK_ShopImages_Shop_Id REFERENCES shop(id_shop)
)

CREATE TABLE review_text (
  id_review_text UNIQUEIDENTIFIER CONSTRAINT PK_ReviewTtext_Id PRIMARY KEY default NEWID(),
  text varchar(255),
  edited int DEFAULT 0, --if its 0 then false and 1 then true
  rating UNIQUEIDENTIFIER CONSTRAINT FK_ReviewText_Ratings_Id REFERENCES ratings(id_rating),
  price UNIQUEIDENTIFIER CONSTRAINT FK_ReviewText_ShopPrices_Id REFERENCES shop_prices(id_shop_prices),
)

CREATE TABLE review_text_person_shop (
  id_review_text_person_shop UNIQUEIDENTIFIER CONSTRAINT PK_ReviewTextPersonShop_Id PRIMARY KEY default NEWID(),
  creation datetime,
  id_shop UNIQUEIDENTIFIER CONSTRAINT FK_ReviewTextPersonShop_Shop_Id REFERENCES shop(id_shop),
  id_person UNIQUEIDENTIFIER CONSTRAINT FK_ReviewTextPersonShop_Persons_Id REFERENCES persons(id_persons),
  id_review_text UNIQUEIDENTIFIER CONSTRAINT FK_ReviewTextPersonShop_ReviewText_Id REFERENCES review_text(id_review_text)
)

CREATE TABLE review_images_person_shop (
  id_review_images_person_shop UNIQUEIDENTIFIER CONSTRAINT PK_ReviewImagesPersonShop_Id PRIMARY KEY default NEWID(),
  creation datetime,
  id_shop UNIQUEIDENTIFIER CONSTRAINT FK_ReviewImagesPersonShop_Shop_Id REFERENCES shop(id_shop),
  id_person UNIQUEIDENTIFIER CONSTRAINT FK_ReviewImagesPersonShop_Persons_Id REFERENCES persons(id_persons),
  id_review_images UNIQUEIDENTIFIER CONSTRAINT FK_ReviewImagesPersonShop_ReviewImages_Id REFERENCES review_images(id_review_images)
)