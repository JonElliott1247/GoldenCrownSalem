USE GoldenCrownSalem;


--Category
DELETE FROM Menu.Category;

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
DELETE FROM.Menu.SpicyOption;

INSERT INTO Menu.SpicyOption(Label) VALUES ('not spicy');
INSERT INTO Menu.SpicyOption(Label) VALUES ('spicy');
INSERT INTO Menu.SpicyOption(Label) VALUES ('extra spicy');
--SELECT Label FROM Menu.SpicyOption;

--FamilyDinner
DELETE FROM Menu.FamilyDinner;

INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) VALUES ('A', 2, 4);
INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) VALUES ('B', 2, 4);
INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) VALUES ('C', 2, 4);
INSERT INTO Menu.FamilyDinner(Label, MinNumOrder, MinNumOrderForSpecial) VALUES ('D', 2, 4);

--MenuItem
DELETE FROM Menu.MenuItem;

INSERT INTO Menu.FamilyDinner(Label, SubLabel, Price, CategoryId, CanBeSpicy, IsSpicyByDefault, DefualtSpicyOptionId, IsAvailable, FamilyDinnerId)
	VALUES ('Golden Crown Appetizer', '(parchment chicken, B.B.Q pork, fried wonton, fried shrimp, shrimp egg roll)', 9.25, SELECT , 

--	MenuItemId			INT IDENTITY(1,1) PRIMARY KEY,
--	Label					VARCHAR(100) NOT NULL,
--	Price					MONEY NOT NULL,
--	CategoryId			INT FOREIGN KEY REFERENCES Menu.Category(CategoryId),
--	CanBeSpicy			BIT,
--	IsSpicyByDefault		BIT NOT NULL,
--	DefaultSpicyOptionId	INT FOREIGN KEY REFERENCES Menu.SpicyOption(SpicyOptionId),
--	IsAvailable			BIT,
--  FamilyDinnerId		INT FOREIGN KEY REFERENCES Menu.FamilyDinner(FamilyDinnerId)