USE GoldenCrownSalem;

--Defensive cleanup
DELETE FROM Menu.FamilyDinnerMenuItem;
DELETE FROM Menu.MenuItem;
DELETE FROM Menu.FamilyDinner;
DELETE FROM Menu.FamilyDinnerMenuItemCategory;
DELETE FROM Menu.SpicyOption;
DELETE FROM Menu.Category;


--Category
INSERT INTO Menu.Category(Label) VALUES ('Appetizers');
INSERT INTO Menu.Category(Label) VALUES ('Soups');
INSERT INTO Menu.Category(Label) VALUES ('Combination Plates');
INSERT INTO Menu.Category(Label) VALUES ('Family Dinner');
INSERT INTO Menu.Category(Label) VALUES ('Chicken');
INSERT INTO Menu.Category(Label) VALUES ('Pork');
INSERT INTO Menu.Category(Label) VALUES ('Sizzling Plates');
INSERT INTO Menu.Category(Label) VALUES ('Vegetarian');
INSERT INTO Menu.Category(Label,SubLabel) VALUES ('Chow Mein','crispy noodles');
INSERT INTO Menu.Category(Label,SubLabel) VALUES ('Lo Mein', 'soft noodles');

INSERT INTO Menu.Category(Label) VALUES ('Chop Suey');
INSERT INTO Menu.Category(Label) VALUES ('Rice');
INSERT INTO Menu.Category(Label) VALUES ('Noodle Soups');
INSERT INTO Menu.Category(Label) VALUES ('American Dinner Menu');
INSERT INTO Menu.Category(Label) VALUES ('Hamburgers and Sandwiches');
INSERT INTO Menu.Category(Label) VALUES ('Salads');
INSERT INTO Menu.Category(Label) VALUES ('Children''s Menu');
INSERT INTO Menu.Category(Label) VALUES ('Beverages');
INSERT INTO Menu.Category(Label) VALUES ('Desserts');
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
	VALUES ('Golden Crown Appetizer', '(parchment chicken, B.B.Q pork, fried wonton, fried shrimp, shrimp egg roll)', 9.25, 
		(SELECT CategoryId FROM Menu.Category WHERE Label = 'Appetizers'), 1, 0, NULL, 1, NULL)
