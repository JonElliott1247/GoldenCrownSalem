USE GoldenCrownSalem;

--*********************************************************************************************************************
--<Defensive cleanup>
--*********************************************************************************************************************
DELETE FROM Menu.MenuItem_CombinationPlateItem;
DELETE FROM Menu.CombinationPlateItem;
DELETE FROM Menu.MenuItem_FamilyDinnerItem;
DELETE FROM Menu.FamilyDinnerItem;
DELETE FROM Menu.MenuItem;
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
		@ChowMeinSub		AS VARCHAR(100)	= 'crispy noodles',
		@LoMein				AS VARCHAR(100)	= 'Lo Mein',
		@LoMeinSub			AS VARCHAR(100) = 'soft noodles',
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
		(@ChowMein, @ChowMeinSub), (@LoMein, @ChowMeinSub);

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
--<MenuItem>
--*********************************************************************************************************************************
INSERT INTO Menu.MenuItem(Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
	VALUES
	--Appetizers
	('Golden Crown Appetizer', 'parchment chicken, BBQ pork, fried wonton, fried shrimp, shrimp egg roll', 9.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('BBQ Pork', NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Sesame Flyboy', '8 total', 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Small Appetizer', 'B.B.Q pork, sesame flyboy, fried wonton', 7.50, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Fried Shrimp', '14 total', 9.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Fried Shrimp', '10 total', 8.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Shrimp Egg Roll', NULL, 6.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Pot Sticklers', NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Vegetable Spring Roll', '4 total', 6.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Parchment Chicken', NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Fried Mushrooms', NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Crab Puffs', NULL, 6.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
	('Fried Won Ton', NULL, 5.50, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),

	--Soups
	('Egg Flower', 'bowl', 4.25, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
	('Egg Flower', 'cup', 1.95, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
	('Won Ton', 'large', 7.25, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
	('Won Ton', 'small', 6.25, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
	('Hot and Sour', NULL, 6.95, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@Spicy)),
	('Wor Won Ton', 'large', 8.50, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
	('Wor Won Ton', 'small', 7.50, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy));

DECLARE @Number1	AS VARCHAR(100)	= 'Number 1', 
		@Number2	AS VARCHAR(100)	= 'Number 2', 
		@Number3	AS VARCHAR(100) = 'Number 3',
		@Number4	AS VARCHAR(100) = 'Number 4',
		@Number5	AS VARCHAR(100) = 'Number 5',
		@Number6	AS VARCHAR(100) = 'Number 6',

		@DinnerA	AS VARCHAR(100) = 'Dinner A',
		@DinnerB	AS VARCHAR(100) = 'Dinner B',
		@DinnerC	AS VARCHAR(100) = 'Dinner C',
		@DinnerD	AS VARCHAR(100) = 'Dinner D',


INSERT INTO Menu.MenuItem(Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
	
	VALUES
	--Combination Plates
	(@Number1, NULL, 8.25, 1, Menu.CategoryId(@CombinationPlate), NULL),
	(@Number2, NULL, 8.50, 1, Menu.CategoryId(@CombinationPlate), NULL),
	(@Number3, NULL, 8.75, 1, Menu.CategoryId(@CombinationPlate), NULL),
	(@Number4, NULL, 9.50, 1, Menu.CategoryId(@CombinationPlate), NULL),
	(@Number5, NULL, 10.25, 1, Menu.CategoryId(@CombinationPlate), NULL),
	(@Number6, NULL, 10.50, 1, Menu.CategoryId(@CombinationPlate), NULL),

	--Family Dinners
	(@DinnerA, NULL, 10.75, 1, Menu.FamilyDinnerId(@DinnerA), NULL),
	(@DinnerB, NULL, 12.75, 1, Menu.FamilyDinnerId(@DinnerB), NULL),
	(@DinnerC, NULL, 12.75, 1, Menu.FamilyDinnerId(@DinnerC), NULL),
	(@DinnerD, NULL, 13.75, 1, Menu.FamilyDinnerId(@DinnerD), NULL);

--SELECT Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId, FamilyDinnerId FROM Menu.MenuItem;
