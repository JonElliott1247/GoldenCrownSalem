USE GoldenCrownSalem;

BEGIN TRANSACTION [Cleanup]

	DROP TABLE IF EXISTS Menu.MenuItem_CombinationPlateItem;
	DROP TABLE IF EXISTS Menu.CombinationPlateItem;
	DROP TABLE IF EXISTS Menu.MenuItem_FamilyDinnerItem;
	DROP TABLE IF EXISTS Menu.FamilyDinnerItem;
	DROP TABLE IF EXISTS Menu.MenuItem;
	DROP TABLE IF EXISTS Menu.SpicyOption;
	DROP TABLE IF EXISTS Menu.Category;

	IF OBJECT_ID (N'Menu.CategoryId', N'FN') IS NOT NULL  
		DROP FUNCTION Menu.CategoryId;

	IF OBJECT_ID (N'Menu.SpicyOptionId', N'FN') IS NOT NULL  
		DROP FUNCTION Menu.SpicyOptionId;

	IF OBJECT_ID (N'Menu.NumSpecialPerFamilyDinnerFunc', N'FN') IS NOT NULL  
		DROP FUNCTION Menu.NumSpecialPerFamilyDinnerFunc;

	DROP SCHEMA IF EXISTS Menu;

COMMIT TRANSACTION [Cleanup]
GO

--Main script
CREATE SCHEMA Menu;
GO

CREATE TABLE Menu.Category
(
	CategoryId		INT IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) UNIQUE NOT NULL,
	SubLabel		VARCHAR(100),
	Path			VARCHAR(100) UNIQUE NOT NULL 
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
	IsAvailable				BIT NOT NULL,
	CategoryId				INT FOREIGN KEY REFERENCES Menu.Category(CategoryId) NOT NULL,
	DefaultSpicyOptionId	INT FOREIGN KEY REFERENCES Menu.SpicyOption(SpicyOptionId),

);
--Guarentee a unique label or unique (label, sublabel) while allowing sublabel to be null
CREATE UNIQUE INDEX UniqueLabelIndex ON Menu.MenuItem(Label) WHERE SubLabel IS NULL;
CREATE UNIQUE INDEX UniqueLabelSubLabelIndex ON Menu.MenuItem(Label, SubLabel);

CREATE TABLE Menu.FamilyDinnerItem
(
	FamilyDinnerItemId			INT IDENTITY(1,1) PRIMARY KEY,
	Label						VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Menu.MenuItem_FamilyDinnerItem
(
	MenuItemFamilyDinnerItemId	INT IDENTITY(1,1) PRIMARY KEY,
	MenuItemId					INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId) NOT NULL,
	FamilyDinnerItemId			INT FOREIGN KEY REFERENCES Menu.FamilyDinnerItem(FamilyDinnerItemId) NOT NULL,
	DefaultSpicyOptionId		INT FOREIGN KEY REFERENCES Menu.SpicyOption(SpicyOptionId) NOT NULL,
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


CREATE TABLE Menu.CombinationPlateItem
(
	CombinationPlateItemId	INT IDENTITY(1,1) PRIMARY KEY,
	Label					VARCHAR(100),
	SubLabel				VARCHAR(100),
	AlternateId				INT FOREIGN KEY REFERENCES Menu.CombinationPlateItem(CombinationPlateItemId),
	DefaultSpicyOptionId	INT FOREIGN KEY REFERENCES Menu.SpicyOption(SpicyOptionId),
	IsSide					BIT NOT NULL,

	CONSTRAINT CombinationPlateItem_UniqueLabel	UNIQUE(Label, SubLabel),
);

CREATE TABLE Menu.MenuItem_CombinationPlateItem
(
	MenuItemFamilyDinnerItem	INT IDENTITY(1,1) PRIMARY KEY,
	MenuItemId					INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId),
	CombinationPlateId			INT FOREIGN KEY REFERENCES Menu.CombinationPlateItem(CombinationPlateItemId),
);


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

--*********************************************************************************************************************
--</PopulateDatabase.sql script helper user defined functions>
--*********************************************************************************************************************

