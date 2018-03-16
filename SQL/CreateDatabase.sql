USE GoldenCrownSalem;

--Defensive cleanup
DROP TABLE IF EXISTS Menu.FamilyDinnerMenuItem;
DROP TABLE IF EXISTS Menu.MenuItem;
DROP TABLE IF EXISTS Menu.FamilyDinner;
DROP TABLE IF EXISTS Menu.FamilyDinnerMenuItemCategory;
DROP TABLE IF EXISTS Menu.SpicyOption;
DROP TABLE IF EXISTS Menu.Category;

IF OBJECT_ID (N'Menu.CategoryId', N'FN') IS NOT NULL  
    DROP FUNCTION Menu.CategoryId;

IF OBJECT_ID (N'Menu.SpicyOptionId', N'FN') IS NOT NULL  
    DROP FUNCTION Menu.SpicyOptionId;

IF OBJECT_ID (N'Menu.FamilyDinnerId', N'FN') IS NOT NULL  
    DROP FUNCTION Menu.FamilyDinnerId;

DROP SCHEMA IF EXISTS Menu;
GO

--Main script
CREATE SCHEMA Menu;
GO

CREATE TABLE Menu.Category
(
	CategoryId	INT IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) UNIQUE NOT NULL,
	SubLabel		VARCHAR(100)
);

CREATE TABLE Menu.SpicyOption
(
	SpicyOptionId	INT	IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Menu.FamilyDinner
(
	FamilyDinnerId			INT IDENTITY(1,1) PRIMARY KEY,
	Label					VARCHAR(100) UNIQUE NOT NULL,
	MinNumOrder				INT NOT NULL,
	MinNumOrderForSpecial	INT NOT NULL
);

CREATE TABLE Menu.MenuItem
(
	MenuItemId				INT IDENTITY(1,1) PRIMARY KEY,
	Label					VARCHAR(100) UNIQUE NOT NULL,
	SubLabel				VARCHAR(100),
	Price					MONEY NOT NULL,
	CategoryId				INT FOREIGN KEY REFERENCES Menu.Category(CategoryId),
	CanBeSpicy				BIT,
	IsSpicyByDefault		BIT NOT NULL,
	DefaultSpicyOptionId	INT FOREIGN KEY REFERENCES Menu.SpicyOption(SpicyOptionId),
	IsAvailable				BIT,
	FamilyDinnerId			INT FOREIGN KEY REFERENCES Menu.FamilyDinner(FamilyDinnerId)
);

CREATE TABLE Menu.FamilyDinnerMenuItemCategory
(
	FamilyDinnerMenuItemCategoryId	INT IDENTITY(1,1) PRIMARY KEY,
	Label							CHAR(1) NOT NULL
);

CREATE TABLE Menu.FamilyDinnerMenuItem
(
	FamilyDinnerMenuItemId			INT IDENTITY(1,1) PRIMARY KEY,
	FamilyDinnerId					INT FOREIGN KEY REFERENCES Menu.FamilyDinner(FamilyDinnerId) NOT NULL,
	MenuItemId						INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId) NOT NULL,
	FamilyDinnerMenuItemCategoryId	INT FOREIGN KEY REFERENCES Menu.FamilyDinnerMenuItemCategory(FamilyDinnerMenuItemCategoryId) NOT NULL
);

--*********************************************************************************************************************
--<Helper user defined functions>
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
--</Helper user defined functions>
--*********************************************************************************************************************