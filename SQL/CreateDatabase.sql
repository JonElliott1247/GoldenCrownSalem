USE GoldenCrownSalem;

--Defensive cleanup
DROP TABLE IF EXISTS Menu.CombinationPlate;
DROP TABLE IF EXISTS Menu.MenuItem_FamilyDinnerItem;
DROP TABLE IF EXISTS Menu.FamilyDinnerItem;
DROP TABLE IF EXISTS Menu.FamilyDinner;
DROP TABLE IF EXISTS Menu.MenuItem;
DROP TABLE IF EXISTS Menu.SpicyOption;
DROP TABLE IF EXISTS Menu.Category;

IF OBJECT_ID (N'Menu.CategoryId', N'FN') IS NOT NULL  
    DROP FUNCTION Menu.CategoryId;

IF OBJECT_ID (N'Menu.SpicyOptionId', N'FN') IS NOT NULL  
    DROP FUNCTION Menu.SpicyOptionId;

IF OBJECT_ID (N'Menu.FamilyDinnerId', N'FN') IS NOT NULL  
    DROP FUNCTION Menu.FamilyDinnerId;

IF OBJECT_ID (N'Menu.NumSpecialPerFamilyDinnerFunc', N'FN') IS NOT NULL  
    DROP FUNCTION Menu.NumSpecialPerFamilyDinnerFunc;

DROP SCHEMA IF EXISTS Menu;
GO

--Main script
CREATE SCHEMA Menu;
GO

CREATE TABLE Menu.Category
(
	CategoryId		INT IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Menu.SpicyOption
(
	SpicyOptionId	INT	IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE Menu.MenuItem
(
	MenuItemId				INT IDENTITY(1,1) PRIMARY KEY,
	Label					VARCHAR(100) NOT NULL,
	SubLabel				VARCHAR(100),
	Price					MONEY NOT NULL,
	IsAvailable				BIT,
	CategoryId				INT FOREIGN KEY REFERENCES Menu.Category(CategoryId),
	DefaultSpicyOptionId	INT FOREIGN KEY REFERENCES Menu.SpicyOption(SpicyOptionId),

	CONSTRAINT UniqueLabel	UNIQUE(Label, SubLabel)
	
);

CREATE TABLE Menu.FamilyDinnerItem
(
	FamilyDinnerItemId			INT IDENTITY(1,1) PRIMARY KEY,
	Label						VARCHAR(100)
);

CREATE TABLE Menu.MenuItem_FamilyDinnerItem
(
	MenuItemFamilyDinnerItem	INT IDENTITY(1,1) PRIMARY KEY,
	MenuItemId					INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId),
	FamilyDinnerItemId			INT FOREIGN KEY REFERENCES Menu.FamilyDinnerItem(FamilyDinnerItemId),
	IsSpecial					BIT NOT NULL
);

GO
CREATE FUNCTION Menu.NumSpecialPerFamilyDinnerFunc(@MenuItemId INT)
RETURNS INT   
AS   
BEGIN
	RETURN (SELECT COUNT(*) FROM Menu.MenuItem_FamilyDinnerItem WHERE IsSpecial = 1 AND MenuItemId = @MenuItemId) 
END; 
GO


ALTER TABLE Menu.MenuItem_FamilyDinnerItem
ADD CONSTRAINT OneSpecialPerFamilyDinner CHECK( (IsSpecial = 0) OR	(Menu.NumSpecialPerFamilyDinnerFunc(MenuItemId) = 0));

/*
CREATE TABLE Menu.CombinationPlate
(
	CombinationPlateId	INT IDENTITY(1,1) PRIMARY KEY

);
*/

--*********************************************************************************************************************
--<PopulateDatabase.sql script helper user defined functions>
--*********************************************************************************************************************
GO
CREATE FUNCTION Menu.CategoryId(@CategoryLabel VARCHAR(100))  
RETURNS INT   
AS   
BEGIN
	RETURN (SELECT CategoryId FROM Menu.Category WHERE Label = @CategoryLabel);
END; 
GO

GO
CREATE FUNCTION Menu.SpicyOptionId(@SpicyOptionLabel VARCHAR(100))  
RETURNS INT   
AS   
BEGIN
	RETURN (SELECT SpicyOptionId FROM Menu.SpicyOption WHERE Label = @SpicyOptionLabel);
END; 
GO

GO
CREATE FUNCTION Menu.FamilyDinnerId(@SpicyOptionLabel VARCHAR(100))  
RETURNS INT   
AS   
BEGIN
	RETURN (SELECT SpicyOptionId FROM Menu.SpicyOption WHERE Label = @SpicyOptionLabel);
END; 
GO

--*********************************************************************************************************************
--</PopulateDatabase.sql script helper user defined functions>
--*********************************************************************************************************************