USE GoldenCrownSalem;

--Defensive cleanup
DELETE FROM Menu.FamilyDinnerMenuItem;
DELETE FROM Menu.MenuItem;
DELETE FROM Menu.FamilyDinner;
DELETE FROM Menu.FamilyDinnerMenuItemCategory;
DELETE FROM Menu.SpicyOption;
DELETE FROM Menu.Category;

--*********************************************************************************************************************
--Category
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
		@ChowMeinSub		AS VARCHAR(100) = 'crispy noodles',
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
		(@ChowMein,@ChowMeinSub), (@LoMein, @LoMeinSub);

--Ids for dependent tables
DECLARE @AppetizerId			AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Appetizer), 
		@SoupId					AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Soup),
		@CombinationPlateId		AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @CombinationPlate),
		@FamilyDinnerId			AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @FamilyDinner),
		@ChickenId				AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Chicken),
		@PorkId					AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Pork),
		@SizzlingPlateId		AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @SizzlingPlate),
		@VegetarianId			AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Vegetarian),
		@ChowMeinId				AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @ChowMein),
		@LoMeinId				AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @LoMein),
		@ChopSueyId				AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @ChopSuey),
		@RiceId					AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Rice),
		@NoodleSoupId			AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @NoodleSoup),
		@AmericanId				AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @American),
		@HamburgerSandwichId	AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @HamburgerSandwich),
		@SaladId				AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Salad),
		@ChildrenMenuId			AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @ChildrenMenu),
		@BeverageId				AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Beverage),
		@DessertId				AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = @Dessert);
--SELECT Label, SubLabel FROM Menu.Category;
--*********************************************************************************************************************
--Category
--*********************************************************************************************************************




--*********************************************************************************************************************************
--SpicyOption
--*********************************************************************************************************************************
DECLARE @NotSpicy AS VARCHAR(100) = 'not spicy', @Spicy AS VARCHAR(100) = 'spicy', @ExtraSpicy AS VARCHAR(100) = 'extra spicy';
INSERT INTO Menu.SpicyOption(Label) VALUES (@NotSpicy), (@Spicy), (@ExtraSpicy);
DECLARE @NotSpicyId		AS INT = (SELECT SpicyOptionId FROM Menu.SpicyOption WHERE Label = @NotSpicy),
		@SpicyId		AS INT = (SELECT SpicyOptionId FROM Menu.SpicyOption WHERE Label = @Spicy),
		@ExtraSpicyId	AS INT = (SELECT SpicyOptionId FROM Menu.SpicyOption WHERE Label = @ExtraSpicy)
--SELECT Label FROM Menu.SpicyOption;
--*********************************************************************************************************************************
--SpicyOption
--*********************************************************************************************************************************



--*********************************************************************************************************************************
--FamilyDinner
--*********************************************************************************************************************************
DECLARE @DinnerA AS CHAR(1) = 'A', @DinnerB AS CHAR(1) = 'B', @DinnerC AS CHAR(1) = 'C', @DinnerD AS CHAR(1) = 'D';
INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) 
			VALUES (@DinnerA, 2, 4), (@DinnerB, 2, 4), (@DinnerC, 2, 4), (@DinnerD, 2, 4);
DECLARE @DinnerAId AS INT = (SELECT FamilyDinnerId FROM Menu.FamilyDinner WHERE Label = @DinnerA), 
		@DinnerBId AS INT = (SELECT FamilyDinnerId FROM Menu.FamilyDinner WHERE Label = @DinnerB),
		@DinnerCId AS INT = (SELECT FamilyDinnerId FROM Menu.FamilyDinner WHERE Label = @DinnerC),
		@DinnerDId AS INT = (SELECT FamilyDinnerId FROM Menu.FamilyDinner WHERE Label = @DinnerD);
--SELECT Label, MinNumOrder, MinNumOrderForSpecial FROM Menu.FamilyDinner
--*********************************************************************************************************************************
--FamilyDinner
--*********************************************************************************************************************************


--*********************************************************************************************************************************
--MenuItem
--*********************************************************************************************************************************
INSERT INTO Menu.MenuItem(	Label, SubLabel, Price, CategoryId, CanBeSpicy, IsSpicyByDefault, 
							DefaultSpicyOptionId, IsAvailable, FamilyDinnerId)
	VALUES 
	('Golden Crown Appetizer', 'parchment chicken, BBQ pork, fried wonton, fried shrimp, shrimp egg roll', 9.25, @AppetizerId, 1, 0, NULL, 1, NULL),
	('BBQ Pork', NULL, 7.25, @AppetizerId, 1, 0, NULL, 1, NULL),
	('Sesame Flyboy', '8 total', 7.25, @AppetizerId, 1, 0, NULL, 1, NULL),
	('Small Appetizer', 'B.B.Q pork, sesame flyboy, fried wonton', 7.50, @AppetizerId, 1, 0, NULL, 1, NULL);
	
	SELECT Label, SubLabel, Price, CategoryId, CanBeSpicy, IsSpicyByDefault, DefaultSpicyOptionId, IsAvailable, FamilyDinnerId FROM Menu.MenuItem;
