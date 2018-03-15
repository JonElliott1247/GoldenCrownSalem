USE GoldenCrownSalem;

--Defensive cleanup
DELETE FROM Menu.FamilyDinnerMenuItem;
DELETE FROM Menu.MenuItem;
DELETE FROM Menu.FamilyDinner;
DELETE FROM Menu.FamilyDinnerMenuItemCategory;
DELETE FROM Menu.SpicyOption;
DELETE FROM Menu.Category;


--Category
DECLARE @Appetizer AS VARCHAR(100)			= 'Appetizers', 
		@Soup AS VARCHAR(100)				= 'Soups',
		@CombinationPlate AS VARCHAR(100)	= 'Combination Plates',
		@FamilyDinner AS VARCHAR(100)		= 'Family Dinner',
		@Chicken AS VARCHAR(100)			= 'Chicken',
		@Pork AS VARCHAR(100)				= 'Pork',
		@SizzlingPlate AS VARCHAR(100)		= 'Sizzling Plates',
		@Vegetarian AS VARCHAR(100)			= 'Vegetarian',
		@ChowMein AS VARCHAR(100)			= 'Chow Mein',
		@LoMein AS VARCHAR(100)				= 'Lo Mein';

INSERT INTO Menu.Category(Label) VALUES 
		(@Appetizer), (@Soup), (@CombinationPlate),(@FamilyDinner),(@Chicken), (@Pork), (@SizzlingPlate), (@Vegetarian);
INSERT INTO Menu.Category(Label, SubLabel) VALUES
		(@ChowMein,'crispy noodles'), (@LoMein, 'soft noodles');

INSERT INTO Menu.Category(Label) VALUES ('Chop Suey');
INSERT INTO Menu.Category(Label) VALUES ('Rice');
INSERT INTO Menu.Category(Label) VALUES ('Noodle Soups');
INSERT INTO Menu.Category(Label) VALUES ('American Dinner Menu');
INSERT INTO Menu.Category(Label) VALUES ('Hamburgers and Sandwiches');
INSERT INTO Menu.Category(Label) VALUES ('Salads');
INSERT INTO Menu.Category(Label) VALUES ('Children''s Menu');
INSERT INTO Menu.Category(Label) VALUES ('Beverages');
INSERT INTO Menu.Category(Label) VALUES ('Desserts');

--Ids for dependent tables
DECLARE @AppetizerId AS INT = (SELECT CategoryId FROM Menu.Category WHERE Label = 'Appetizers');
	--SELECT Label, SubLabel FROM Menu.Category;


--SpicyOption
INSERT INTO Menu.SpicyOption(Label) VALUES ('not spicy');
INSERT INTO Menu.SpicyOption(Label) VALUES ('spicy');
INSERT INTO Menu.SpicyOption(Label) VALUES ('extra spicy');
	--SELECT Label FROM Menu.SpicyOption;

--FamilyDinner
INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) VALUES ('A', 2, 4);
INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) VALUES ('B', 2, 4);
INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) VALUES ('C', 2, 4);
INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) VALUES ('D', 2, 4);
	--SELECT Label, MinNumOrder, MinNumOrderForSpecial FROM Menu.FamilyDinner
--MenuItem

INSERT INTO Menu.MenuItem(Label, SubLabel, Price, CategoryId, CanBeSpicy, IsSpicyByDefault, DefaultSpicyOptionId, IsAvailable, FamilyDinnerId)
	VALUES 
	('Golden Crown Appetizer', '(parchment chicken, BBQ pork, fried wonton, fried shrimp, shrimp egg roll)', 9.25, @AppetizerId, 1, 0, NULL, 1, NULL),
	('BBQ Pork', NULL, 7.25, @AppetizerId, 1, 0, NULL, 1, NULL),
	('Sesame Flyboy', '8 total', 7.25, @AppetizerId, 1, 0, NULL, 1, NULL),
	('Small Appetizer', 'B.B.Q pork, sesame flyboy, fried wonton', 7.50, @AppetizerId, 1, 0, NULL, 1, NULL);
	
	SELECT Label, SubLabel, Price, CategoryId, CanBeSpicy, IsSpicyByDefault, DefaultSpicyOptionId, IsAvailable, FamilyDinnerId FROM Menu.MenuItem;
