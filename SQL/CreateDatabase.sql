USE GoldenCrownSalem;

BEGIN TRANSACTION [Cleanup]

	DROP TABLE IF EXISTS Menu.MenuItem_CombinationPlateItem;
	DROP TABLE IF EXISTS Menu.CombinationPlateItem;
	DROP TABLE IF EXISTS Menu.MenuItem_FamilyDinnerItem;
	DROP TABLE IF EXISTS Menu.FamilyDinnerItem;
	DROP TABLE IF EXISTS Sales.OrderItem;
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
	
	DROP TABLE IF EXISTS Sales.[Order];
	DROP TABLE IF EXISTS Sales.Account;

	IF OBJECT_ID (N'Sales.OrderSubTotal', N'FN') IS NOT NULL
		DROP FUNCTION Sales.OrderSubTotal;

	IF OBJECT_ID (N'Sales.OrderItemSubTotal', N'FN') IS NOT NULL
		DROP FUNCTION Sales.OrderItemSubTotal;

	DROP SCHEMA IF EXISTS Sales;

COMMIT TRANSACTION [Cleanup]
GO

--Main script
CREATE SCHEMA Menu;
GO

CREATE FUNCTION Menu.MenuItemLabelAndSubLabelCheckConstraint(@MenuLabel VARCHAR(100))  
RETURNS BIT   
AS   
BEGIN
	DECLARE @LabelCount INT = (SELECT COUNT(MenuItemId) FROM Menu.MenuItem WHERE Label = @MenuLabel);

	--1 means if there is a duplicate entry on Label then those entries have SubLabel values that are not null
	DECLARE @ReturnValue BIT = 1;
	IF @LabelCount != 1
		IF (SELECT COUNT(MenuItemId) FROM Menu.MenuItem WHERE Label = @MenuLabel AND SubLabel IS NOT NULL) != @LabelCount
			SET @ReturnValue = 0;

	RETURN @ReturnValue;
END;
GO

CREATE TABLE Menu.Category
(
	CategoryId		INT IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) UNIQUE NOT NULL,
	Description		VARCHAR(100)
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
	Description				VARCHAR(100),
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
	MenuItemFamilyDinnerItemId	INT IDENTITY(1,1) PRIMARY KEY,
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
	RETURN (SELECT CombinationPlateItemId FROM Menu.CombinationPlateItem WHERE Label = @CombinationPlateItemLabel)
END;
GO

--*********************************************************************************************************************
--</PopulateDatabase.sql script helper user defined functions>
--*********************************************************************************************************************

CREATE SCHEMA Sales;
GO

CREATE TABLE Sales.Account
(
	AccountId	INT IDENTITY(1,1) PRIMARY KEY,
	UserName	VARCHAR(50),
	Salt		BINARY(16),
	Hash		BINARY(36)
);

GO
CREATE FUNCTION Sales.OrderSubTotal(@OrderId INT)
RETURNS MONEY
AS
BEGIN
	RETURN (SELECT SUM(SubTotal) FROM Sales.OrderItem AS OrderItem WHERE OrderItem.OrderId = @OrderId)
END;
GO

CREATE TABLE Sales.[Order]
(
	OrderId		INT IDENTITY(1,1) PRIMARY KEY,
	AccountId	INT FOREIGN KEY REFERENCES Sales.Account(AccountId) NOT NULL,
	SubTotal	AS Sales.OrderSubTotal(OrderId),
	Tip			MONEY DEFAULT 0 NOT NULL
);

GO
CREATE FUNCTION Sales.OrderItemSubTotal(@MenuItemId INT, @Quantity INT)
RETURNS MONEY
AS
BEGIN
	RETURN ((SELECT Price FROM Menu.MenuItem AS MenuItem WHERE MenuItem.MenuItemId = MenuItemId) * @Quantity)
END;
GO

CREATE TABLE Sales.OrderItem
(
	OrderItemId	INT IDENTITY(1,1) PRIMARY KEY,
	MenuItemId	INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId) NOT NULL,
	OrderId		INT FOREIGN KEY REFERENCES Sales.[Order](OrderId) NOT NULL,
	Quantity	INT DEFAULT 1 NOT NULL,
	SubTotal	AS Sales.OrderItemSubTotal(MenuItemId, Quantity)
);
