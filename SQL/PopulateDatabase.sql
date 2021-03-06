USE GoldenCrownSalem;

--*********************************************************************************************************************
--<Defensive cleanup>
--*********************************************************************************************************************
BEGIN TRANSACTION [RemoveRecords]

	DELETE FROM Menu.MenuItem_CombinationPlateItem;
	DELETE FROM Menu.CombinationPlateItem;
	DELETE FROM Menu.MenuItem_FamilyDinnerItem;
	DELETE FROM Menu.FamilyDinnerItem;
	DELETE FROM Menu.MenuItem;
	DELETE FROM Menu.SpicyOption;
	DELETE FROM Menu.Category;

COMMIT TRANSACTION [RemoveRecords]
--*********************************************************************************************************************
--</Defensive cleanup>
--*********************************************************************************************************************


--*********************************************************************************************************************
--<Category>
--*********************************************************************************************************************
BEGIN TRANSACTION [AddCategoryRecords]

	DECLARE @Appetizer			AS VARCHAR(100)	= 'Appetizers', 
			@Soup				AS VARCHAR(100)	= 'Soups',
			@CombinationPlate	AS VARCHAR(100)	= 'Combination Plates',
			@FamilyDinner		AS VARCHAR(100)	= 'Family Dinner',
			@Chicken			AS VARCHAR(100)	= 'Chicken',
			@Pork				AS VARCHAR(100)	= 'Pork',
			@Beef				AS VARCHAR(100) = 'Beef',
			@Seafood			AS VARCHAR(100) = 'Seafood',
			@Curries			AS VARCHAR(100) = 'Curries from the Indies',
			@SizzlingPlate		AS VARCHAR(100)	= 'Sizzling Plates',
			@Vegetarian			AS VARCHAR(100)	= 'Vegetarian',
			@ChowMein			AS VARCHAR(100)	= 'Chow Mein',
			@ChowMeinDes		AS VARCHAR(100)	= 'crispy noodles',
			@LoMein				AS VARCHAR(100)	= 'Lo Mein',
			@LoMeinDes			AS VARCHAR(100) = 'soft noodles',
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
			(@Appetizer),	(@Soup), (@CombinationPlate), (@FamilyDinner),	
			(@Chicken), (@Pork), (@Beef), (@Seafood), (@Curries),
			(@SizzlingPlate),	(@Vegetarian), (@ChopSuey), (@Rice),
			(@NoodleSoup),	(@American), (@HamburgerSandwich), (@Salad),			
			(@ChildrenMenu), (@Beverage),	(@Dessert);

	INSERT INTO Menu.Category(Label, Description) VALUES
			(@ChowMein, @ChowMeinDes), (@LoMein, @ChowMeinDes);

COMMIT TRANSACTION [AddCategoryRecords]

--SELECT Label, SubLabel FROM Menu.Category;
--*********************************************************************************************************************
--</Category>
--*********************************************************************************************************************



--*********************************************************************************************************************************
--<SpicyOption>
--*********************************************************************************************************************************
BEGIN TRANSACTION [AddSpicyOptionRecords]

	DECLARE @NotSpicy	AS VARCHAR(100)	= 'not spicy', 
			@Spicy		AS VARCHAR(100)	= 'spicy', 
			@ExtraSpicy AS VARCHAR(100) = 'extra spicy';

	INSERT INTO Menu.SpicyOption(Label) VALUES (@NotSpicy), (@Spicy), (@ExtraSpicy);

COMMIT TRANSACTION [AddSpicyOptionRecords]
--SELECT Label FROM Menu.SpicyOption;
--*********************************************************************************************************************************
--</SpicyOption>
--*********************************************************************************************************************************


--*********************************************************************************************************************************
--<MenuItem>
--*********************************************************************************************************************************
BEGIN TRANSACTION [AddMenuItemRecords]

	INSERT INTO Menu.MenuItem(Label, SubLabel, Description, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Appetizers
		('Golden Crown Appetizer', NULL, 'parchment chicken, BBQ pork, fried wonton, fried shrimp, shrimp egg roll', 9.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('BBQ Pork', NULL, NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Sesame Flyboy','8 total', NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Small Appetizer', NULL, 'B.B.Q pork, sesame flyboy, fried wonton', 7.50, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Fried Shrimp','14 total', NULL, 9.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Fried Shrimp','10 total', NULL, 8.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Egg Roll', NULL, NULL, 6.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Pot Sticklers', NULL, NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Vegetable Spring Roll', '4 total', NULL, 6.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Parchment Chicken', NULL, NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Fried Mushrooms', NULL, NULL, 7.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Crab Puffs', NULL, NULL, 6.25, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),
		('Fried Won Ton', NULL, NULL, 5.50, 1, Menu.CategoryId(@Appetizer), Menu.SpicyOptionId(@NotSpicy)),

		--Soups
		('Egg Flower', 'bowl', NULL, 4.25, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
		('Egg Flower', 'cup', NULL, 1.95, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
		('Won Ton', 'large', NULL, 7.25, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
		('Won Ton', 'small', NULL, 6.25, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
		('Hot and Sour', NULL, NULL, 6.95, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@Spicy)),
		('Wor Won Ton', 'large', NULL, 8.50, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy)),
		('Wor Won Ton', 'small', NULL, 7.50, 1, Menu.CategoryId(@Soup), Menu.SpicyOptionId(@NotSpicy));

	DECLARE @Number1	AS VARCHAR(100)	= 'Number 1', 
			@Number2	AS VARCHAR(100)	= 'Number 2', 
			@Number3	AS VARCHAR(100) = 'Number 3',
			@Number4	AS VARCHAR(100) = 'Number 4',
			@Number5	AS VARCHAR(100) = 'Number 5',
			@Number6	AS VARCHAR(100) = 'Number 6',

			@DinnerA	AS VARCHAR(100) = 'Dinner A',
			@DinnerB	AS VARCHAR(100) = 'Dinner B',
			@DinnerC	AS VARCHAR(100) = 'Dinner C',
			@DinnerD	AS VARCHAR(100) = 'Dinner D';


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
		(@DinnerA, NULL, 10.75, 1, Menu.CategoryId(@FamilyDinner), NULL),
		(@DinnerB, NULL, 12.75, 1, Menu.CategoryId(@FamilyDinner), NULL),
		(@DinnerC, NULL, 12.75, 1, Menu.CategoryId(@FamilyDinner), NULL),
		(@DinnerD, NULL, 13.75, 1, Menu.CategoryId(@FamilyDinner), NULL);

		INSERT INTO Menu.MenuItem(Label, SubLabel, Description, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Chicken
		('Diced Almond Chicken', NULL, NULL, 7.75, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Sesame Chicken', NULL, NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Lemon Chicken', NULL, NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Moo Goo Gai Pan', NULL, NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Sweet & Sour Chicken', NULL, NULL, 8.95, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Almond Fried Chicken', NULL, NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Cashew Nut Chicken', NULL, NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Szechwan Chicken', NULL, NULL, 8.95, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@Spicy)),
		('Chicken with Black and Fresh Mushrooms', NULL, NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Green Beans in Garlic Sauce with Chicken', NULL, NULL, 9.50, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Pineapple Chicken Chow Yuk.', NULL, 'Chicken saut�ed w/vegetables in a pineapple sauce', 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Chow Yuk', NULL, 'Chicken saut�ed w/vegetables in a Chinese sauce', 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Cantonese', NULL, 'Chicken saut�ed w/vegetables in a black bean and garlic sauce', 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Kung Pao Chicken', NULL, 'Diced chicken saut�ed w/bell peppers, onions, and celery, topped with peanuts', 9.50, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@Spicy)),
		('Hot and Spiced Chicken', NULL, 'Chicken saut�ed with vegetables in our Chef�s spicy sauce', 9.50, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@Spicy)),
		('General Tso�s Chicken', NULL, 'Sesame battered chicken with bell peppers tossed in our Chef�s spicy sauce', 9.50, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@Spicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Description, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Pork
		('Sweet & Sour Pork', NULL, NULL, 8.95, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('Sweet & Sour Spareribs', NULL, NULL, 8.95, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		(' B.B.Q Chow Yuk', NULL, NULL, 9.25, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('Green Beans in Garlic Sauce with B.B.Q Pork', NULL, NULL, 9.50, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('B.B.Q Pork Chow Dun', NULL, 'Pork, bean sprouts, snow peas, water chestnuts, and carrots folded into beaten eggs', 9.25, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('Mu-Shu Pork', NULL, 'Pork saut�ed w/cabbage, scallions, bamboo shoots, and eggs. Served with Mandarin pan cakes', 9.25, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('Mao Pao Tofu', NULL, 'Minced pork saut�ed w/peas, carrots, water chestnuts, and tofu in a black bean sauce', 9.50, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@Spicy)),

		--Beef
		('Beef with Oyster Sauce', NULL,  NULL, 9.75, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Beef and Broccoli', NULL,  NULL, 9.25, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Kung Pao Beef', NULL,  NULL, 9.50, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@Spicy)),

		('Beef Tomato Chow Yuk', NULL,  'Beef saut�ed with vegetables in a tomato sauce', 9.25, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Green Pepper Steak', NULL,  'Beef steak saut�ed w/green bell peppers and onions in a black bean sauce', 9.25, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Steak Cantonese', NULL,  'New York steak saut�ed w/mushrooms, snow peas, and onions in a Cantonese sauce', 10.95, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Under the Rainbow', NULL,  'Beef saut�ed w/vegetables and bean sprouts, topped w/crispy vermicelli noodles', 9.75, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Ginger Beef', NULL,  'Beef saut�ed w/ginger, scallions, and onions on a bed of bean sprouts', 9.75, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Szechwan Beef', NULL,  'Sesame battered beef w/shredded carrots, pea pods and onions tossed in our spicy sauce', 9.50, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@Spicy)),

		--Seafood
		('Shrimp Broccoli', NULL, NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Chow Dun', NULL, NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp with Lobster Sauce', NULL, NULL, 10.50, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Squid with Ginger and Onions', NULL, NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Golden Crown Special Chow Yuk', NULL, NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Sweet & Sour Fish', NULL, NULL, 10.25, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Chow Yuk', NULL, NULL, 10.25, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Kung Pao Shrimp', NULL, NULL, 10.25, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@Spicy)),
		('Kung Pao Squid', NULL, NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@Spicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Description, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Curries
		('Chicken', NULL, NULL, 9.25, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Shrimp', NULL, NULL, 10.25, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Squid', NULL, NULL, 9.75, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),

		('Beef', NULL, NULL, 9.25, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Seafood', NULL, NULL, 10.75, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Vegetable', NULL, NULL, 8.75, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),

		--Sizzling Plates
		('Sizzling Beef', NULL, 'Beef saut�ed w/onions, carrots, peas, and mushrooms in our special sauce', 10.95, 1, Menu.CategoryId(@SizzlingPlate), Menu.SpicyOptionId(@NotSpicy)),
		('Sizzling Chicken', NULL, 'Chicken saut�ed w/pea pods, mushrooms, and onions in our traditional sauce', 10.95, 1, Menu.CategoryId(@SizzlingPlate), Menu.SpicyOptionId(@NotSpicy)),
		('Sizzling Shrimp', NULL, 'Shrimp sauteed w/onions, mushrooms, scallions, peas, and carrots in our special sauce', 10.95, 1, Menu.CategoryId(@SizzlingPlate), Menu.SpicyOptionId(@NotSpicy)),
		('Sizzling Seafood', NULL, 'Shrimp, scallops, squid, imitation crab sauteed w/wegetables in our traditional Chinese sauce', 10.95, 1, Menu.CategoryId(@SizzlingPlate), Menu.SpicyOptionId(@NotSpicy)),

		--Vegetarian
		('Egg Foo Young', NULL, NULL, 7.50, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Chinese Vegetable Deluxe', NULL, NULL, 8.75, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Sweet & Sour Tofu', NULL, 'Battered tofu served with sweet & sour sauce, bell peppers, carrots and onions', 8.95, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Tofu with Oyster Sauce', NULL, 'Tofu stir fry with black mushrooms, fresh mushrooms and onions in a black bean sauce', 8.95, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Kung Pao Tofu', NULL, 'Tofu stir fry with bell peppers and a variety of vegetables', 8.95, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@Spicy)),
		('Vegetable Supreme', NULL, NULL, 8.75, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Tofu with Oyster SauceKung Pao Vegetables', NULL, NULL, 8.95, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@Spicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Description, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Chow Mein
		('B.B.Q Pork Chow Mein', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Chow Mein', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Chow Mein', NULL, NULL, 8.75, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Diced Almond Chicken Chow Mein', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Chow Mein', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Vegetable Chow Mein', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Tomato Chow Mein', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),

		--Lo Mein
		('B.B.Q Pork Lo Mein', NULL, NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Lo Mein', NULL, NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Lo Mein', NULL, NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Vegetable Lo Mein', NULL, NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Golden Crown Special Mein', NULL, NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Maylan Chow Mein', NULL, NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@Spicy)),
		('Pan Fried Noodle', 'large', NULL, 4.25, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Pan Fried Noodle', 'small', NULL, 2.95, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),

		--Chop Suey
		('Shrimp Chop Suey', NULL, NULL, 8.95, 1, Menu.CategoryId(@ChopSuey), Menu.SpicyOptionId(@NotSpicy)),
		('B.B.Q Pork Chop Suey', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChopSuey), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Chop Suey', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChopSuey), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Chop Suey', NULL, NULL, 7.95, 1, Menu.CategoryId(@ChopSuey), Menu.SpicyOptionId(@NotSpicy)),

		--Rice
		('Vegetable Fried Rice', NULL, NULL, 7.25, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy)),
		('B.B.Q Pork Fried Rice', NULL, NULL, 7.25, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Fried Rice', NULL, NULL, 7.25, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy)),
		('Steam Rice', 'cup', NULL, 1.00, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy)),

		('Fried Rice', 'cup', NULL, 1.25, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy)),
		('B.B.Q Pork Fried Rice with Bean Sprout', NULL, NULL, 7.25, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken, Ham, or Beef Fried Rice', NULL, NULL, 7.25, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken or Beef Rice Casserole', NULL, NULL, 7.25, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy)),
		('Golden Crown Special Fried Rice', NULL, NULL, 7.25, 1, Menu.CategoryId(@Rice), Menu.SpicyOptionId(@NotSpicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Noodle Soups
		('B.B.Q Pork Noodle', NULL, 7.25, 1, Menu.CategoryId(@NoodleSoup), Menu.SpicyOptionId(@NotSpicy)),
		('Teriyaki Chicken Noodle', NULL, 7.95, 1, Menu.CategoryId(@NoodleSoup), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Noodle', NULL, 7.25, 1, Menu.CategoryId(@NoodleSoup), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Noodle with Vegetables', NULL, 8.75, 1, Menu.CategoryId(@NoodleSoup), Menu.SpicyOptionId(@NotSpicy)),
		('B.B.Q Pork, Chicken, or Beef Noodle with Vegetables', NULL, 7.95, 1, Menu.CategoryId(@NoodleSoup), Menu.SpicyOptionId(@NotSpicy)),
		('B.B.Q Pork, Chicken, or Beef Noodle with Curry & Vegetable', NULL, 7.95, 1, Menu.CategoryId(@NoodleSoup), Menu.SpicyOptionId(@Spicy)),

		--American
		('Chicken Fried Steak', NULL, 8.25, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('New York Steak', NULL, 11.50, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Kalua Pork', NULL, 7.95, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Teriyaki Chicken', NULL, 8.25, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Seafood Platter', NULL, 9.50, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Wiki Wiki Beef', NULL, 7.95, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),

		--Burger and Sandwiches
		('Hamburger', NULL, 5.25, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Teriyaki Burger', NULL, 5.50, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Three Decker', NULL, 7.25, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('French Fries', NULL, 2.95, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Cheeseburger', NULL, 5.50, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Teriyaki Chicken Burger', NULL, 5.50, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Crispy Chicken', NULL, 9.50, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),
		('Onion Rings', NULL, 9.50, 1, Menu.CategoryId(@American), Menu.SpicyOptionId(@NotSpicy)),

		--Salads
		('Mixed Green Salad', NULL, 2.95, 1, Menu.CategoryId(@Salad), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Salad', NULL, 8.75, 1, Menu.CategoryId(@Salad), Menu.SpicyOptionId(@NotSpicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Description, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		('Seafood Salad', NULL, 'imitation crab and  bay shrimp' , 7.50, 1, Menu.CategoryId(@Salad), Menu.SpicyOptionId(@NotSpicy)),
		('Chef�s Salad', NULL, NULL, 7.50, 1, Menu.CategoryId(@Salad), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Salad', NULL, 'Cantonese dressing', 7.25, 1, Menu.CategoryId(@Salad), Menu.SpicyOptionId(@NotSpicy)),
		('Crab Salad', NULL, 'imitation crab', 6.75, 1, Menu.CategoryId(@Salad), Menu.SpicyOptionId(@NotSpicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Description, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Children's Menu
		('Chicken Drumsticks', NULL, 'served with vegetables and french fries', 6.95, 1, Menu.CategoryId(@ChildrenMenu), NULL),
		('Ground Beef Steak', NULL, 'served with vegetables and french fries', 6.95, 1, Menu.CategoryId(@ChildrenMenu), NULL),
		('Sweet & Sour Chicken and Port Fried Rice', NULL, 'served with egg flower soup', 6.95, 1, Menu.CategoryId(@ChildrenMenu), NULL),
		('Fried Shrimp and Port Fried Rice', NULL, 'served with egg flower soup', 7.50, 1, Menu.CategoryId(@ChildrenMenu), NULL);

	INSERT INTO Menu.MenuItem(Label, SubLabel, Description, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Beverages
		('Soft Drink', NULL, 'Pepsi Products', 2.00, 1, Menu.CategoryId(@Beverage), NULL),
		('Juice', NULL, NULL, 2.00, 1, Menu.CategoryId(@Beverage), NULL),
		('Milk', NULL, NULL, 2.00, 1, Menu.CategoryId(@Beverage), NULL),
		('Ice Tea', NULL, NULL, 2.00, 1, Menu.CategoryId(@Beverage), NULL),
		('Coffee', NULL, NULL, 2.00, 1, Menu.CategoryId(@Beverage), NULL),
		('Hot Tea', NULL, NULL, 2.00, 1, Menu.CategoryId(@Beverage), NULL);

	INSERT INTO Menu.MenuItem(Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Ice Cream
		('Deep Fried Ice Cream', NULL, 3.25, 1, Menu.CategoryId(@Dessert), NULL),
		('Ice Cream', 'peppermint', 3.25, 1, Menu.CategoryId(@Dessert), NULL),
		('Ice Cream', 'vanilla', 3.25, 1, Menu.CategoryId(@Dessert), NULL);



COMMIT TRANSACTION [AddMenuItemRecords]
SELECT Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId FROM Menu.MenuItem;
--*********************************************************************************************************************************
--</MenuItem>
--*********************************************************************************************************************************

--*********************************************************************************************************************************
--<FamilyDinnerItem>
--*********************************************************************************************************************************
BEGIN TRANSACTION [AddFamilyDinnerItemRecords]


	DECLARE @EggRoll					AS VARCHAR(100)	= 'Egg Roll', 
			@BbqPork					AS VARCHAR(100)	= 'B.B.Q Pork', 
			@ChickenChowMein			AS VARCHAR(100) = 'Chicken Chow Mein',
			@SweetSourPork				AS VARCHAR(100) = 'Sweet and Sour Pork',
			@SpecialFriedRice			AS VARCHAR(100) = 'Special Fried Rice',
			@BbqPorkChowYuk				AS VARCHAR(100) = 'B.B.Q Pork Chow Yuk',
			@FriedWonTon				AS VARCHAR(100) = 'Fried Won Ton',
			@CashewNutChicken			AS VARCHAR(100) = 'Cashew Nut Chicken',
			@SweetSourPrawns			AS VARCHAR(100) = 'Sweet and Sour Prawns',
			@BeefBroccoli				AS VARCHAR(100) = 'Beef and Broccoli',
			@AlmondFriedChicken			AS VARCHAR(100) = 'Almond Fried Chicken',
			@SesameFlyboy				AS VARCHAR(100) = 'Sesame Flyboy',
			@KungPaoBeef				AS VARCHAR(100) = 'Kung Pao Beef',
			@PineappleSweetSourChicken	AS VARCHAR(100) = 'Pineapple Sweet and Sour Chicken',
			@FriedShrimp				AS VARCHAR(100) = 'Fried Shrimp',
			@SpecialChowYuk				AS VARCHAR(100) = 'Special Chow Yuk',
			@ParchmentChicken			AS VARCHAR(100) = 'Parchment Chicken',
			@SteakCantonese				AS VARCHAR(100) = 'Steak Cantonese',
			@MandarinChicken			AS VARCHAR(100) = 'Mandarin Chicken',
			@NeptuneSeafoodNest			AS VARCHAR(100) = 'Neptune Seafood Nest';



	INSERT INTO Menu.FamilyDinnerItem(Label, DefaultSpicyOptionId)
	VALUES
	(@EggRoll, Menu.SpicyOptionId(@NotSpicy)), (@BbqPork, Menu.SpicyOptionId(@NotSpicy)), (@ChickenChowMein, Menu.SpicyOptionId(@NotSpicy)),
	(@SweetSourPork, Menu.SpicyOptionId(@NotSpicy)), (@SpecialFriedRice, Menu.SpicyOptionId(@NotSpicy)), (@BbqPorkChowYuk, Menu.SpicyOptionId(@NotSpicy)), 
	(@FriedWonTon, Menu.SpicyOptionId(@NotSpicy)), (@CashewNutChicken, Menu.SpicyOptionId(@NotSpicy)), (@SweetSourPrawns, Menu.SpicyOptionId(@NotSpicy)),
	(@BeefBroccoli, Menu.SpicyOptionId(@NotSpicy)), (@AlmondFriedChicken, Menu.SpicyOptionId(@NotSpicy)), (@SesameFlyboy, Menu.SpicyOptionId(@NotSpicy)),
	(@KungPaoBeef, Menu.SpicyOptionId(@NotSpicy)), (@PineappleSweetSourChicken, Menu.SpicyOptionId(@NotSpicy)), (@FriedShrimp, Menu.SpicyOptionId(@NotSpicy)),
	(@SpecialChowYuk, Menu.SpicyOptionId(@NotSpicy)), (@ParchmentChicken, Menu.SpicyOptionId(@NotSpicy)), (@SteakCantonese, Menu.SpicyOptionId(@NotSpicy)),
	(@MandarinChicken, Menu.SpicyOptionId(@NotSpicy)), (@NeptuneSeafoodNest, Menu.SpicyOptionId(@NotSpicy));

COMMIT TRANSACTION [AddFamilyDinnerItemRecords]
SELECT FamilyDinnerItemId, Label FROM Menu.FamilyDinnerItem;
--*********************************************************************************************************************************
--</FamilyDinnerItem>
--*********************************************************************************************************************************

--*********************************************************************************************************************************
--<MenuItem_FamilyDinnerItem>
--*********************************************************************************************************************************

BEGIN TRANSACTION [MiFdiRecords]


	INSERT INTO Menu.MenuItem_FamilyDinnerItem(MenuItemId, FamilyDinnerItemId, IsSpecial, IsAppetizer, IsEntree)
	VALUES
	(Menu.MenuItemId(@DinnerA), Menu.FamilyDinnerItemId(@BbqPork), 0, 1, 0),
	(Menu.MenuItemId(@DinnerA), Menu.FamilyDinnerItemId(@ChickenChowMein), 0, 0, 1),
	(Menu.MenuItemId(@DinnerA), Menu.FamilyDinnerItemId(@SweetSourPork), 0, 0, 1),
	(Menu.MenuItemId(@DinnerA), Menu.FamilyDinnerItemId(@SpecialFriedRice), 0, 0, 1),
	(Menu.MenuItemId(@DinnerA), Menu.FamilyDinnerItemId(@BbqPorkChowYuk), 1, 0, 0),

	(Menu.MenuItemId(@DinnerB), Menu.FamilyDinnerItemId(@SesameFlyboy), 0, 1, 0),
	(Menu.MenuItemId(@DinnerB), Menu.FamilyDinnerItemId(@BbqPork), 0, 1, 0),
	(Menu.MenuItemId(@DinnerB), Menu.FamilyDinnerItemId(@KungPaoBeef), 0, 0, 1),
	(Menu.MenuItemId(@DinnerB), Menu.FamilyDinnerItemId(@PineappleSweetSourChicken), 0, 0, 1),
	(Menu.MenuItemId(@DinnerB), Menu.FamilyDinnerItemId(@FriedShrimp), 0, 0, 1),
	(Menu.MenuItemId(@DinnerB), Menu.FamilyDinnerItemId(@SpecialFriedRice), 0, 0, 1),
	(Menu.MenuItemId(@DinnerB), Menu.FamilyDinnerItemId(@SpecialChowYuk), 1, 0, 0),

	(Menu.MenuItemId(@DinnerC), Menu.FamilyDinnerItemId(@FriedWonTon), 0, 1, 0),
	(Menu.MenuItemId(@DinnerC), Menu.FamilyDinnerItemId(@BbqPork), 0, 1, 0),
	(Menu.MenuItemId(@DinnerC), Menu.FamilyDinnerItemId(@CashewNutChicken), 0, 0, 1),
	(Menu.MenuItemId(@DinnerC), Menu.FamilyDinnerItemId(@SweetSourPrawns), 0, 0, 1),
	(Menu.MenuItemId(@DinnerC), Menu.FamilyDinnerItemId(@BeefBroccoli), 0, 0, 1),
	(Menu.MenuItemId(@DinnerC), Menu.FamilyDinnerItemId(@SpecialFriedRice), 0, 0, 1),
	(Menu.MenuItemId(@DinnerC), Menu.FamilyDinnerItemId(@AlmondFriedChicken), 1, 0, 0),

	(Menu.MenuItemId(@DinnerD), Menu.FamilyDinnerItemId(@ParchmentChicken), 0, 1, 0),
	(Menu.MenuItemId(@DinnerD), Menu.FamilyDinnerItemId(@BbqPork), 0, 1, 0),
	(Menu.MenuItemId(@DinnerD), Menu.FamilyDinnerItemId(@SteakCantonese), 0, 0, 1),
	(Menu.MenuItemId(@DinnerD), Menu.FamilyDinnerItemId(@SpecialChowYuk), 0, 0, 1),
	(Menu.MenuItemId(@DinnerD), Menu.FamilyDinnerItemId(@MandarinChicken), 0, 0, 1),
	(Menu.MenuItemId(@DinnerD), Menu.FamilyDinnerItemId(@SpecialFriedRice), 0, 0, 1),
	(Menu.MenuItemId(@DinnerD), Menu.FamilyDinnerItemId(@NeptuneSeafoodNest), 1, 0, 0);






COMMIT TRANSACTION [MiFdiRecords]
--SELECT * FROM Menu.MenuItem_FamilyDinnerItem;

--*********************************************************************************************************************************
--</MenuItem_FamilyDinnerItem>
--*********************************************************************************************************************************

--*********************************************************************************************************************************
--<CombinationPlateItem>
--*********************************************************************************************************************************

BEGIN TRANSACTION [AddCombinationPlateItemRecords]


	DECLARE @EggRollCombo					AS VARCHAR(100)	= 'Egg Roll', 
			@PorkChowMeinCombo				AS VARCHAR(100)	= 'Pork Chow Mein', 
			@EggFooYoungCombo				AS VARCHAR(100) = 'Egg Foo Young',
			@SweetSourChickenCombo			AS VARCHAR(100) = 'Sweet and Sour Chicken',
			@PorkFriedRiceCombo				AS VARCHAR(100) = 'Pork Fried Rice',
			@FriedShrimpCombo				AS VARCHAR(100) = 'Fried Shrimp',
			@SweetSourPorkCombo				AS VARCHAR(100) = 'Sweet and Sour Pork',
			@BbqPorkCombo					AS VARCHAR(100) = 'B.B.Q Pork',
			@DicedAlmondChickenCombo		AS VARCHAR(100) = 'DicedAlmondChickenCombo',
			@ParchmentChickenCombo			AS VARCHAR(100) = 'ParchmentChicken',
			@SweetSourShrimpCombo			AS VARCHAR(100) = 'Sweet and Sour Shrimp',
			@BbqPorkChowYukCombo			AS VARCHAR(100) = 'B.B.Q Pork Chow Yuk';

	INSERT INTO Menu.CombinationPlateItem(Label, DefaultSpicyOptionId)
	VALUES
	(@EggRollCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@PorkChowMeinCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@EggFooYoungCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@SweetSourChickenCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@PorkFriedRiceCombo, Menu.SpicyOptionId(@NotSpicy)),

	(@FriedShrimpCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@SweetSourPorkCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@BbqPorkCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@DicedAlmondChickenCombo, Menu.SpicyOptionId(@NotSpicy)),

	(@ParchmentChickenCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@SweetSourShrimpCombo, Menu.SpicyOptionId(@NotSpicy)),
	(@BbqPorkChowYukCombo, Menu.SpicyOptionId(@NotSpicy));


COMMIT TRANSACTION [AddCombinationPlateItemRecords]
--SELECT * FROM Menu.CombinationPlateItem;

--*********************************************************************************************************************************
--</CombinationPlateItem>
--*********************************************************************************************************************************



--*********************************************************************************************************************************
--<MenuItem_CombinationPlateItem>
--*********************************************************************************************************************************

BEGIN TRANSACTION [AddMenuItem_ComboItemRecords]



	INSERT INTO Menu.MenuItem_CombinationPlateItem(MenuItemId, CombinationPlateItemId)
	VALUES
	(Menu.MenuItemId(@Number1), Menu.CombinationPlateItemId(@EggRollCombo)),
	(Menu.MenuItemId(@Number1), Menu.CombinationPlateItemId(@PorkChowMeinCombo)),
	(Menu.MenuItemId(@Number1), Menu.CombinationPlateItemId(@EggFooYoungCombo)),
	
	(Menu.MenuItemId(@Number2), Menu.CombinationPlateItemId(@SweetSourChickenCombo)),
	(Menu.MenuItemId(@Number2), Menu.CombinationPlateItemId(@PorkChowMeinCombo)),
	(Menu.MenuItemId(@Number2), Menu.CombinationPlateItemId(@PorkFriedRiceCombo)),

	(Menu.MenuItemId(@Number3), Menu.CombinationPlateItemId(@FriedShrimpCombo)),
	(Menu.MenuItemId(@Number3), Menu.CombinationPlateItemId(@SweetSourPork)),
	(Menu.MenuItemId(@Number3), Menu.CombinationPlateItemId(@PorkChowMeinCombo)),

	
	(Menu.MenuItemId(@Number4), Menu.CombinationPlateItemId(@BbqPorkCombo)),
	(Menu.MenuItemId(@Number4), Menu.CombinationPlateItemId(@DicedAlmondChickenCombo)),
	(Menu.MenuItemId(@Number4), Menu.CombinationPlateItemId(@SweetSourChickenCombo)),
	(Menu.MenuItemId(@Number4), Menu.CombinationPlateItemId(@PorkFriedRiceCombo)),

	
	(Menu.MenuItemId(@Number5), Menu.CombinationPlateItemId(@FriedShrimpCombo)),
	(Menu.MenuItemId(@Number5), Menu.CombinationPlateItemId(@SweetSourPorkCombo)),
	(Menu.MenuItemId(@Number5), Menu.CombinationPlateItemId(@DicedAlmondChickenCombo)),
	(Menu.MenuItemId(@Number5), Menu.CombinationPlateItemId(@PorkFriedRiceCombo)),


	(Menu.MenuItemId(@Number6), Menu.CombinationPlateItemId(@ParchmentChickenCombo)),
	(Menu.MenuItemId(@Number6), Menu.CombinationPlateItemId(@SweetSourShrimpCombo)),
	(Menu.MenuItemId(@Number6), Menu.CombinationPlateItemId(@BbqPorkChowYukCombo)),
	(Menu.MenuItemId(@Number6), Menu.CombinationPlateItemId(@PorkFriedRiceCombo));
	

COMMIT TRANSACTION [AddMenuItem_ComboItemRecords]
SELECT * FROM Menu.MenuItem_CombinationPlateItem;

--*********************************************************************************************************************************
--</MenuItem_CombinationPlateItem>
--*********************************************************************************************************************************