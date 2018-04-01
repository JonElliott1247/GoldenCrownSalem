USE GoldenCrownSalem;

BEGIN TRANSACTION [Cleanup]

	DROP TABLE IF EXISTS Menu.Path;
	DROP TABLE IF EXISTS Menu.MenuItem_CombinationPlateItem;
	DROP TABLE IF EXISTS Menu.CombinationPlateItem;
	DROP TABLE IF EXISTS Menu.MenuItem_FamilyDinnerItem;
	DROP TABLE IF EXISTS Menu.FamilyDinnerItem;
	DROP TABLE IF EXISTS Menu.MenuItem;
	DROP TABLE IF EXISTS Menu.SpicyOption;
	DROP TABLE IF EXISTS Menu.Category;

	IF OBJECT_ID (N'Menu.MenuItemLabelAndSubLabelCheckConstraint', N'FN') IS NOT NULL  
		DROP FUNCTION Menu.MenuItemLabelAndSubLabelCheckConstraint;

	IF OBJECT_ID (N'Menu.CategoryId', N'FN') IS NOT NULL  
		DROP FUNCTION Menu.CategoryId;

	IF OBJECT_ID (N'Menu.SpicyOptionId', N'FN') IS NOT NULL  
		DROP FUNCTION Menu.SpicyOptionId;

	IF OBJECT_ID (N'Menu.NumSpecialPerFamilyDinnerFunc', N'FN') IS NOT NULL  
		DROP FUNCTION Menu.NumSpecialPerFamilyDinnerFunc;

	IF OBJECT_ID (N'Menu.FamilyDinnerItemId', N'FN') IS NOT NULL
		DROP FUNCTION Menu.FamilyDInnerItemId;

	IF OBJECT_ID (N'Menu.MenuItemId', N'FN') IS NOT NULL
		DROP FUNCTION Menu.MenuItemId;

	IF OBJECT_ID (N'Menu.CombinationPlateItemId', N'FN') IS NOT NULL
		DROP FUNCTION Menu.CombinationPlateItemId;

	DROP SCHEMA IF EXISTS Menu;

COMMIT TRANSACTION [Cleanup]
GO

--Main script
CREATE SCHEMA Menu;
GO

CREATE FUNCTION Menu.MenuItemLabelAndSubLabelCheckConstraint(@CategoryLabel VARCHAR(100))  
RETURNS BIT   
AS   
BEGIN
	DECLARE @LabelCount INT = (SELECT COUNT(CategoryId) FROM Menu.Category WHERE Label = @CategoryLabel);

	--1 means if there is a duplicate entry on Label then those entries have SubLabel values that are not null
	DECLARE @ReturnValue BIT = 1;
	IF @LabelCount != 1
		IF (SELECT COUNT(CategoryId) FROM Menu.Category WHERE Label = @CategoryLabel AND SubLabel IS NOT NULL) != @LabelCount
			SET @ReturnValue = 0;

	RETURN @ReturnValue;
END; 
GO

CREATE TABLE Menu.Path
(
	PathId		INT IDENTITY(1,1) PRIMARY KEY,
	Path		VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Menu.Category
(
	CategoryId		INT IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) UNIQUE NOT NULL,
	SubLabel		VARCHAR(100),
	Path			VARCHAR(100) UNIQUE NOT NULL,

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

	--Supplements the two indexes below
	CHECK (Menu.MenuItemLabelAndSubLabelCheckConstraint(Label) = 1)
);
--Guarantee a unique label or unique (label, sublabel) while allowing sublabel to be null
CREATE UNIQUE INDEX UniqueLabelIndex ON Menu.MenuItem(Label) WHERE SubLabel IS NULL;
CREATE UNIQUE INDEX UniqueLabelSubLabelIndex ON Menu.MenuItem(Label, SubLabel);

CREATE TABLE Menu.FamilyDinnerItem
(
	FamilyDinnerItemId			INT IDENTITY(1,1) PRIMARY KEY,
	Label						VARCHAR(100) UNIQUE NOT NULL,
	DefaultSpicyOptionId		INT FOREIGN KEY REFERENCES Menu.SpicyOption(SpicyOptionId) NOT NULL,
);

CREATE TABLE Menu.MenuItem_FamilyDinnerItem
(
	MenuItemFamilyDinnerItemId	INT IDENTITY(1,1) PRIMARY KEY,
	MenuItemId					INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId) NOT NULL,
	FamilyDinnerItemId			INT FOREIGN KEY REFERENCES Menu.FamilyDinnerItem(FamilyDinnerItemId) NOT NULL,
	IsSpecial					BIT NOT NULL,
	IsAppetizer					BIT NOT NULL,
	IsEntree					BIT NOT NULL,

	--Make sure any individual entry is either a special, or appetizer or entree noninclusive.
	CHECK	(	((IsSpecial = 1) OR (IsAppetizer = 1) OR (IsEntree = 1))
				AND (NOT (IsSpecial = 1 AND IsAppetizer = 1))
				AND (NOT (IsSpecial = 1 AND IsEntree = 1))
				AND (NOT (IsAppetizer = 1 AND IsEntree = 1))

			)
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
ADD CONSTRAINT OneSpecialPerFamilyDinner CHECK( (IsSpecial = 0) OR	(Menu.NumSpecialPerFamilyDinnerFunc(MenuItemId) = 1));


CREATE TABLE Menu.CombinationPlateItem
(
	CombinationPlateItemId	INT IDENTITY(1,1) PRIMARY KEY,
	Label					VARCHAR(100) UNIQUE NOT NULL,
	DefaultSpicyOptionId	INT FOREIGN KEY REFERENCES Menu.SpicyOption(SpicyOptionId)
);

CREATE TABLE Menu.MenuItem_CombinationPlateItem
(
	MenuItemFamilyDinnerItem	INT IDENTITY(1,1) PRIMARY KEY,
	MenuItemId					INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId),
	CombinationPlateItemId		INT FOREIGN KEY REFERENCES Menu.CombinationPlateItem(CombinationPlateItemId)
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


CREATE FUNCTION Menu.SpicyOptionId(@SpicyOptionLabel VARCHAR(100))  
RETURNS INT   
AS   
BEGIN
	RETURN (SELECT SpicyOptionId FROM Menu.SpicyOption WHERE Label = @SpicyOptionLabel);
END; 
GO

CREATE FUNCTION Menu.FamilyDinnerItemId(@FamilyDinnerItemLabel VARCHAR(100))
RETURNS INT
AS
BEGIN
	RETURN (SELECT FamilyDinnerItemId FROM Menu.FamilyDinnerItem WHERE Label = @FamilyDinnerItemLabel)
END;
GO

CREATE FUNCTION Menu.MenuItemId(@MenuItemLabel VARCHAR(100))
RETURNS INT
AS
BEGIN
	RETURN (SELECT MenuItemId FROM Menu.MenuItem WHERE Label = @MenuItemLabel)
END;
GO


CREATE FUNCTION Menu.CombinationPlateItemId(@CombinationPlateItemLabel VARCHAR(100))
RETURNS INT
AS
BEGIN
	RETURN (SELECT MenuItemId FROM Menu.MenuItem WHERE Label = @CombinationPlateItemLabel)
END;
GO

--*********************************************************************************************************************
--</PopulateDatabase.sql script helper user defined functions>
--*********************************************************************************************************************

