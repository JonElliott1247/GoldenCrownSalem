USE GoldenCrownSalem;

DROP TABLE IF EXISTS Menu.FamilyDinnerMenuItem;
DROP TABLE IF EXISTS Menu.MenuItem;
DROP TABLE IF EXISTS Menu.FamilyDinner;
DROP TABLE IF EXISTS Menu.FamilyDinnerMenuItemCategory;
DROP TABLE IF EXISTS Menu.SpicyOption;
DROP TABLE IF EXISTS Menu.Category;

DROP SCHEMA IF EXISTS Menu;
GO

CREATE SCHEMA Menu;
GO

CREATE TABLE Menu.Category
(
	CategoryId	INT IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) NOT NULL,
	SubLabel		VARCHAR(100)
);

CREATE TABLE Menu.SpicyOption
(
	SpicyOptionId	INT	IDENTITY(1,1) PRIMARY KEY,
	Label			VARCHAR(100) NOT NULL
);

CREATE TABLE Menu.FamilyDinner
(
	FamilyDinnerId			INT IDENTITY(1,1) PRIMARY KEY,
	Label					VARCHAR(100) NOT NULL,
	MinNumOrder				INT NOT NULL,
	MinNumOrderForSpecial	INT NOT NULL
);

CREATE TABLE Menu.MenuItem
(
	MenuItemId				INT IDENTITY(1,1) PRIMARY KEY,
	Label					VARCHAR(100) NOT NULL,
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
	Label							VARCHAR(100) NOT NULL
);

CREATE TABLE Menu.FamilyDinnerMenuItem
(
	FamilyDinnerMenuItemId			INT IDENTITY(1,1) PRIMARY KEY,
	FamilyDinnerId					INT FOREIGN KEY REFERENCES Menu.FamilyDinner(FamilyDinnerId) NOT NULL,
	MenuItemId						INT FOREIGN KEY REFERENCES Menu.MenuItem(MenuItemId) NOT NULL,
	FamilyDinnerMenuItemCategoryId	INT FOREIGN KEY REFERENCES Menu.FamilyDinnerMenuItemCategory(FamilyDinnerMenuItemCategoryId) NOT NULL
);