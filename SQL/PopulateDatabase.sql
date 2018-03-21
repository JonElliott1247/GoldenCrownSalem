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
			(@Pork), (@Beef), (@Seafood), (@Curries),	(@SizzlingPlate),	(@Vegetarian),			(@ChopSuey),		(@Rice),
			(@NoodleSoup),	(@American),		(@HamburgerSandwich),	(@Salad),			(@ChildrenMenu),
			(@Beverage),	(@Dessert);

	INSERT INTO Menu.Category(Label, SubLabel) VALUES
			(@ChowMein, @ChowMeinSub), (@LoMein, @ChowMeinSub);

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
		(@DinnerD, NULL, 13.75, 1, Menu.CategoryId(@FamilyDinner), NULL),

		--Chicken
		('Diced Almond Chicken', NULL, 7.75, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Sesame Chicken', NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Lemon Chicken', NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Moo Goo Gai Pan', NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Sweet & Sour Chicken', NULL, 8.95, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Almond Fried Chicken', NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Cashew Nut Chicken', NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Szechwan Chicken', NULL, 8.95, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@Spicy)),
		('Chicken with Black and Fresh Mushrooms', NULL, 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Green Beans in Garlic Sauce with Chicken', NULL, 9.50, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Pineapple Chicken Chow Yuk.', 'Chicken sautéed w/vegetables in a pineapple sauce', 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Chow Yuk', 'Chicken sautéed w/vegetables in a Chinese sauce', 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Cantonese', 'Chicken sautéed w/vegetables in a black bean and garlic sauce', 9.25, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@NotSpicy)),
		('Kung Pao Chicken', 'Diced chicken sautéed w/bell peppers, onions, and celery, topped with peanuts', 9.50, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@Spicy)),
		('Hot and Spiced Chicken', 'Chicken sautéed with vegetables in our Chef’s spicy sauce', 9.50, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@Spicy)),
		('General Tso’s Chicken', 'Sesame battered chicken with bell peppers tossed in our Chef’s spicy sauce', 9.50, 1, Menu.CategoryId(@Chicken), Menu.SpicyOptionId(@Spicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Pork
		('Sweet & Sour Pork', NULL, 8.95, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('Sweet & Sour Spareribs', NULL, 8.95, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		(' B.B.Q Chow Yuk', NULL, 9.25, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('Green Beans in Garlic Sauce with B.B.Q Pork', NULL, 9.50, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('B.B.Q Pork Chow Dun', 'Pork, bean sprouts, snow peas, water chestnuts, and carrots folded into beaten eggs', 9.25, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('Mu-Shu Pork', 'Pork sautéed w/cabbage, scallions, bamboo shoots, and eggs. Served with Mandarin pan cakes', 9.25, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@NotSpicy)),
		('Mao Pao Tofu', 'Minced pork sautéed w/peas, carrots, water chestnuts, and tofu in a black bean sauce', 9.50, 1, Menu.CategoryId(@Pork), Menu.SpicyOptionId(@Spicy)),

		--Beef
		('Beef with Oyster Sauce',  NULL, 9.75, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Beef and Broccoli',  NULL, 9.25, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Kung Pao Beef',  NULL, 9.50, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@Spicy)),

		('Beef Tomato Chow Yuk',  'Beef sautéed with vegetables in a tomato sauce', 9.25, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Green Pepper Steak',  'Beef steak sautéed w/green bell peppers and onions in a black bean sauce', 9.25, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Steak Cantonese',  'New York steak sautéed w/mushrooms, snow peas, and onions in a Cantonese sauce', 10.95, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Under the Rainbow',  'Beef sautéed w/vegetables and bean sprouts, topped w/crispy vermicelli noodles', 9.75, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Ginger Beef',  'Beef sautéed w/ginger, scallions, and onions on a bed of bean sprouts', 9.75, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@NotSpicy)),
		('Szechwan Beef',  'Sesame battered beef w/shredded carrots, pea pods and onions tossed in our spicy sauce', 9.50, 1, Menu.CategoryId(@Beef), Menu.SpicyOptionId(@Spicy)),

		--Seafood
		('Shrimp Broccoli', NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Chow Dun', NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp with Lobster Sauce', NULL, 10.50, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Squid with Ginger and Onions', NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Golden Crown Special Chow Yuk', NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Sweet & Sour Fish', NULL, 10.25, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Chow Yuk', NULL, 10.25, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@NotSpicy)),
		('Kung Pao Shrimp', NULL, 10.25, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@Spicy)),
		('Kung Pao Squid', NULL, 9.75, 1, Menu.CategoryId(@Seafood), Menu.SpicyOptionId(@Spicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Curries
		('Chicken', NULL, 9.25, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Shrimp', NULL, 10.25, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Squid', NULL, 9.75, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Beef', NULL, 9.25, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Seafood', NULL, 10.75, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),
		('Vegetable', NULL, 8.75, 1, Menu.CategoryId(@Curries), Menu.SpicyOptionId(@Spicy)),

		--Sizzling Plates
		('Sizzling Beef', 'Beef sautéed w/onions, carrots, peas, and mushrooms in our special sauce', 10.95, 1, Menu.CategoryId(@SizzlingPlate), Menu.SpicyOptionId(@NotSpicy)),
		('Sizzling Chicken', 'Chicken sautéed w/pea pods, mushrooms, and onions in our traditional sauce', 10.95, 1, Menu.CategoryId(@SizzlingPlate), Menu.SpicyOptionId(@NotSpicy)),
		('Sizzling Shrimp', 'Shrimp sauteed w/onions, mushrooms, scallions, peas, and carrots in our special sauce', 10.95, 1, Menu.CategoryId(@SizzlingPlate), Menu.SpicyOptionId(@NotSpicy)),
		('Sizzling Seafood', 'Shrimp, scallops, squid, imitation crab sauteed w/wegetables in our traditional Chinese sauce', 10.95, 1, Menu.CategoryId(@SizzlingPlate), Menu.SpicyOptionId(@NotSpicy)),

		--Vegetarian
		('Egg Foo Young', NULL, 7.50, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Chinese Vegetable Deluxe', NULL, 8.75, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Sweet & Sour Tofu', 'Battered tofu served with sweet & sour sauce, bell peppers, carrots and onions', 8.95, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Tofu with Oyster Sauce', 'Tofu stir fry with black mushrooms, fresh mushrooms and onions in a black bean sauce', 8.95, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Kung Pao Tofu', 'Tofu stir fry with bell peppers and a variety of vegetables', 8.95, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@Spicy)),
		('Vegetable Supreme', NULL, 8.75, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@NotSpicy)),
		('Tofu with Oyster SauceKung Pao Vegetables', NULL, 8.95, 1, Menu.CategoryId(@Vegetarian), Menu.SpicyOptionId(@Spicy));

	INSERT INTO Menu.MenuItem(Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId)
		VALUES
		--Chow Mein
		('B.B.Q Pork Chow Mein', NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Chow Mein', NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Shrimp Chow Mein', NULL, 8.75, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Diced Almond Chicken Chow Mein', NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Chow Mein', NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Vegetable Chow Mein', NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Tomato Chow Mein', NULL, 7.95, 1, Menu.CategoryId(@ChowMein), Menu.SpicyOptionId(@NotSpicy)),

		--Lo Mein
		('B.B.Q Pork Lo Mein', NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Lo Mein', NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Lo Mein', NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Vegetable Lo Mein', NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Golden Crown Special Mein', NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Maylan Chow Mein', NULL, 8.75, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@Spicy)),
		('Pan Fried Noodle', 'large', 4.25, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),
		('Pan Fried Noodle', 'small', 2.95, 1, Menu.CategoryId(@LoMein), Menu.SpicyOptionId(@NotSpicy)),

		--Chop Suey
		('Shrimp Chop Suey', NULL, 8.95, 1, Menu.CategoryId(@ChopSuey), Menu.SpicyOptionId(@NotSpicy)),
		('B.B.Q Pork Chop Suey', NULL, 7.95, 1, Menu.CategoryId(@ChopSuey), Menu.SpicyOptionId(@NotSpicy)),
		('Chicken Chop Suey', NULL, 7.95, 1, Menu.CategoryId(@ChopSuey), Menu.SpicyOptionId(@NotSpicy)),
		('Beef Chop Suey', NULL, 7.95, 1, Menu.CategoryId(@ChopSuey), Menu.SpicyOptionId(@NotSpicy));




COMMIT TRANSACTION [AddMenuItemRecords]
SELECT Label, SubLabel, Price, IsAvailable, CategoryId, DefaultSpicyOptionId FROM Menu.MenuItem;
--*********************************************************************************************************************************
--</MenuItem>
--*********************************************************************************************************************************