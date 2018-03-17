USE GoldenCrownSalem;

--Defensive cleanup
DROP TABLE IF EXISTS Menu.FamilyDinnerMenuItem;
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

IF OBJECT_ID (N'Menu.OneSpecialPerFamilyDinnerFunc', N'FN') IS NOT NULL  
    DROP FUNCTION Menu.OneSpecialPerFamilyDinnerFunc;

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

CREATE TABLE Menu.FamilyDinner
(
	FamilyDinnerId			INT IDENTITY(1,1) PRIMARY KEY,
	MenuItemId				INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId),
	MinNumOrder				INT NOT NULL,
	MinNumOrderForSpecial	INT NOT NULL
);

CREATE TABLE Menu.FamilyDinnerMenuItem
(
	FamilyDinnerMenuItemId			INT IDENTITY(1,1) PRIMARY KEY,
	FamilyDinnerId					INT FOREIGN KEY REFERENCES Menu.FamilyDinner(FamilyDinnerId) NOT NULL,
	MenuItemId						INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId) NOT NULL,
	Label							VARCHAR(100),
	IsSpecial						BIT NOT NULL
);

GO
CREATE FUNCTION Menu.OneSpecialPerFamilyDinnerFunc(@FamilyDinnerId VARCHAR(100))
RETURNS INT   
AS   
BEGIN
	RETURN (SELECT COUNT(*) FROM Menu.FamilyDInnerMenuItem WHERE IsSpecial = 1 AND FamilyDinnerId = @FamilyDinnerId);
END; 
GO

ALTER TABLE Menu.FamilyDinnerMenuItem
ADD CONSTRAINT OneSpecialPerFamilyDinner CHECK(	(IsSpecial = 0)
											OR	(Menu.OneSpecialPerFamilyDinnerFunc(FamilyDinnerId) = 0))

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