USE GoldenCrownSalem;

--*********************************************************************************************************************
--<Defensive cleanup>
--*********************************************************************************************************************
DELETE FROM Menu.FamilyDinnerMenuItem;
DELETE FROM Menu.MenuItem;
DELETE FROM Menu.FamilyDinner;
DELETE FROM Menu.FamilyDinnerMenuItemCategory;
DELETE FROM Menu.SpicyOption;
DELETE FROM Menu.Category;

--*********************************************************************************************************************
--</Defensive cleanup>
--*********************************************************************************************************************


--*********************************************************************************************************************
--<Category>
--*********************************************************************************************************************

DECLARE @Appetizer			AS VARCHAR(100)	= 'Appetizers', 
		@Soup				AS VARCHAR(100)	= 'Soups',
		@CombinationPlate	AS VARCHAR(100)	= 'Combination Plates',
		@FamilyDinner		AS VARCHAR(100)	= 'Family Dinner',
		@Chicken			AS VARCHAR(100)	= 'Chicken',
		@Pork				AS VARCHAR(100)	= 'Pork',
		@SizzlingPlate		AS VARCHAR(100)	= 'Sizzling Plates',
		@Vegetarian			AS VARCHAR(100)	= 'Vegetarian',
		@ChowMein			AS VARCHAR(100)	= 'Chow Mein',
		@LoMein				AS VARCHAR(100)	= 'Lo Mein',
		@ChopSuey			AS VARCHAR(100) = 'Chop Suey',
		@Rice				AS VARCHAR(100) = 'Rice',
		@NoodleSoup			AS VARCHAR(100) = 'Noodle Soups',
		@American			AS VARCHAR(100) = 'American Dinner Menu',
		@HamburgerSandwich	AS VARCHAR(100)	= 'Hamburgers and Sandwiches',
		@Salad				AS VARCHAR(100) = 'Salads',
		@ChildrenMenu		AS VARCHAR(100) = 'Children''s Menu',
		@Beverage			AS VARCHAR(100) = 'Beverages',
		@Dessert			AS VARCHAR(100) = 'Desserts';

INSERT INTO Menu.Category(Label) VALUES 
		(@Appetizer),	(@Soup),			(@CombinationPlate),	(@FamilyDinner),	(@Chicken),
		(@Pork),		(@SizzlingPlate),	(@Vegetarian),			(@ChopSuey),		(@Rice),
		(@NoodleSoup),	(@American),		(@HamburgerSandwich),	(@Salad),			(@ChildrenMenu),
		(@Beverage),	(@Dessert);

INSERT INTO Menu.Category(Label, SubLabel) VALUES
		(@ChowMein, 'crispy noodles'), (@LoMein, 'soft noodles');

--SELECT Label, SubLabel FROM Menu.Category;
--*********************************************************************************************************************
--</Category>
--*********************************************************************************************************************



--*********************************************************************************************************************************
--<SpicyOption>
--*********************************************************************************************************************************
DECLARE @NotSpicy	AS VARCHAR(100)	= 'not spicy', 
		@Spicy		AS VARCHAR(100)	= 'spicy', 
		@ExtraSpicy AS VARCHAR(100) = 'extra spicy';

INSERT INTO Menu.SpicyOption(Label) VALUES (@NotSpicy), (@Spicy), (@ExtraSpicy);
--SELECT Label FROM Menu.SpicyOption;
--*********************************************************************************************************************************
--</SpicyOption>
--*********************************************************************************************************************************



--*********************************************************************************************************************************
--<FamilyDinner>
--*********************************************************************************************************************************
DECLARE @DinnerA AS CHAR(1) = 'A', 
		@DinnerB AS CHAR(1) = 'B', 
		@DinnerC AS CHAR(1) = 'C', 
		@DinnerD AS CHAR(1) = 'D';

INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) 
			VALUES (@DinnerA, 2, 4), (@DinnerB, 2, 4), (@DinnerC, 2, 4), (@DinnerD, 2, 4);
--SELECT Label, MinNumOrder, MinNumOrderForSpecial FROM Menu.FamilyDinner
--*********************************************************************************************************************************
--</FamilyDinner>
--*********************************************************************************************************************************


--*********************************************************************************************************************************
--<MenuItem>
--*********************************************************************************************************************************
INSERT INTO Menu.MenuItem(Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId, FamilyDinnerId)
	VALUES 
	('Golden Crown Appetizer', 'parchment chicken, BBQ pork, fried wonton, fried shrimp, shrimp egg roll', 9.25, 1, 
		Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy), NULL),
	('BBQ Pork', NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy), NULL),
	('Sesame Flyboy', '8 total', 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy), NULL),
	('Small Appetizer', 'B.B.Q pork, sesame flyboy, fried wonton', 7.50, 1, 
		Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy), NULL);
	
	SELECT Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId, FamilyDinnerId FROM Menu.MenuItem;
