# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

UserRecipe.destroy_all
Instruction.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
User.destroy_all

User.create!(
  image: 'https://i.pravatar.cc/150?img=14',
  username: 'mr_cook',
  email: 'teddy_cooks@zmail.com',
  password: '123',
  first_name: 'Ted',
  last_name: 'Mcpherson',
  street: '123 Password St.',
  city: 'Las Santos',
  state: 'CA',
  zip: '90210'
)

FactoryBot.create_list(:user, 8)

user1 = User.all[0]
user2 = User.all[1]
user3 = User.all[2]
user4 = User.all[3]
user5 = User.all[4]
user6 = User.all[5]
user7 = User.all[6]
user8 = User.all[7]

user1.recipes.create!(
  image: 'https://galleykitchengal.files.wordpress.com/2013/01/dec2012-jan2013-004.jpg',
  title: 'Easy Stir-Fry',
  description: 'This easy stir-fry recipe is ideal for quick and easy weeknight dinners. Once you master the basic formula, you can make endless variations!',
  charity_id: '4593516',
  charity_name: 'HUNGRY NO MORE',
  avg_rating: 3.9
)
user1.recipes.first.ingredients.create!([
  { name: 'cornstarch', amount: '1 tbsp' },
  { name: 'orange juice', amount: '1 cup' },
  { name: 'soy sauce', amount: '2 tbsp' },
  { name: 'garlic cloves, minced', amount: '2' },
  { name: 'ground ginger', amount: '1/4 tsp' },
  { name: 'pork tenderloin, cut into thin strips', amount: '1 lbs' },
  { name: 'canola oil', amount: '1 tbsp' },
  { name: 'fresh snow peas', amount: '1/4 lbs' },
  { name: 'sweet red pepper, julienned', amount: '1/2' },
  { name: 'cooked rice', amount: '2 servings' },
  { name: 'green onion, chopped', amount: 'as wanted' },
  ])
  
  user1.recipes.first.instructions.create!([
  { description: "Make stir-fry sauce. In a small bowl, combine cornstarch, orange juice, soy sauce, garlic and ginger until smooth; set aside." },
  { description: "Sear the meat. The meat or protein cooks first, seasoning the fat in the skillet. In a large skillet or wok, stir-fry pork in oil until lightly browned, 5 minutes; drain." },
  { description: "Toss in veggies. Whatever veggies you’re using go in next. Whatever you’re using, make sure to cut everything to the same size. Here, add the onion, peas and red pepper; cook and stir until crisp-tender, 3-5 minutes." },
  { description: "Add sauce. Cooking the sauce for a few minutes allows it to thicken up. Stir orange juice mixture and add to the pan. Bring to a boil; cook and stir until thickened, about 2 minutes." },
  { description: "Serve with carb of choice. Stir-fries are so full of flavor, they’re usually served on top of a plain base, which absorbs flavor from the sauce. We like to serve this with rice, rice noodles, zoodles or steamed vegetables." },
  ])

user2.recipes.create!(
  image: 'https://i.redd.it/pj0n019xjf511.jpg',
  title: 'The Best Fish-Tacos',
  description: 'I like to pair pan-fried tilapia with a cool and creamy slaw for a flavorful fish taco recipe—easy and delicious! The simple, nutritious ingredients and kid-friendly taste make this Mexican-inspired dish a perfect weeknight dinner.',
  charity_id: '0545998',
  charity_name: 'SALVATION ARMY',
  avg_rating: 4.1
)
user2.recipes.first.ingredients.create!([
  { name: 'fresh tilapa fillets', amount: '1 1/2 lbs' },
  { name: 'all purpose flour', amount: '1/4 cup' },
  { name: 'taco seasoning', amount: '1 packet' },
  { name: 'salt', amount: '1 1/2 tsp' },
  { name: 'pepper', amount: '1/2 tsp' },
  { name: 'canola oil', amount: '2 tbsp' },
  { name: 'corn/flour torillas', amount: 'as needed' },
  { name: 'coleslaw', amount: '8 ounces' },
  { name: 'mayonnaise', amount: '2 tbsp' },
  { name: 'sour cream', amount: '2 tbsp' },
  { name: 'lime juice', amount: '1/2 lime' },
  { name: 'honey', amount: '1 tbsp' }
  ])
  user2.recipes.first.instructions.create!([
    { description: "In a large bowl, whisk together mayonnaise, sour cream, lime juice, honey, salt and pepper. Add coleslaw mix or shredded cabbage and gently toss to coat. Cover and refrigerate for at least 30 minutes, or up to 8 hours." },
    { description: "In a shallow dish, combine flour, taco seasoning, salt and pepper. Add the tilapia and lightly coat on both sides. Heat oil in a large skillet over medium-high heat. Shake excess flour off of the tilapia and place in the skillet. Brown fish on both sides (about 2-3 minutes per side). Flake into large chunks." },
    { description: "Toast the corn tortillas in a dry skillet over medium heat for about 30 seconds per side. Alternatively, you can wrap the tortillas in stacks of five in foil and warm in a 350°F oven for 10-15 minutes (or until heated through)." },
    { description: "Fill each warm tortilla with flaked tilapia, slaw and other toppings of choice." },
    ])

user3.recipes.create!(
  image: 'https://thekitchenprescription.com/wp-content/uploads/2011/02/meatballs.jpg',
  title: 'Mothers Meat Balls',
  description: 'Wondering what the secret is to making gorgeous, tender meatballs in a cinch? My easy meatball recipe shows you how to whip up this delicious comfort food quickly.',
  charity_id: '6048381',
  charity_name: 'DENVER FOUNDATION',
  avg_rating: 3.0
)
user3.recipes.first.ingredients.create!([
  { name: 'large eggs', amount: '2' },
  { name: 'water', amount: '1/4 cup' },
  { name: 'soft breadcrumbs', amount: '1 1/3 cup' },
  { name: 'grated parmesan', amount: '2/3 cup' },
  { name: 'garlic cloves, minced', amount: '2' },
  { name: 'italian seasoning', amount: '2 tsp' },
  { name: 'salt', amount: '1 1/2 tasp' },
  { name: 'pepper', amount: '1/4 tsp' },
  { name: 'ground beef', amount: '2 lbs' }
  ])
user3.recipes.first.instructions.create!([
  { description: "Pour the eggs, onion, garlic, water, breadcrumbs, Parmesan and seasonings into a large bowl. Whisk it well until all of the ingredients are evenly dispersed. The eggs and breadcrumbs are essential for binding the meat. Thanks to their moisture content, eggs help keep your meatballs lovely and tender." },
  { description: "Crumble the ground beef into the egg mixture. Use your hands to combine everything but do not overwork the beef. I can’t stress this enough! If you overdo it, you run the risk of tough meatballs. Instead, gently work the mix until it’s just combined. Once you’re happy with the beef mixture, lightly shape the meatballs to be about 1 to 1 ½ inches. You can make larger meatballs, if you choose." },
  { description: "Grease a rack and place it in a shallow baking tray. I pour a little olive oil onto a paper towel and rub the rack down, but a nonstick cooking spray would work here. Arrange the meatballs, and then put them in the oven. Bake at 375° for about 15 to 18 minutes, or until your instant-read thermometer says they’re cooked through (160-165°)." },
  ])

user4.recipes.create!(
  image: 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2009/3/31/0/CA1D13_17844_s4x3.jpg.rend.hgtvcom.826.620.suffix/1371589466492.jpeg',
  title: 'Prosciutto Pasta Toss',
  description: 'I love quick, simple dishes, and this pasta with prosciutto and peas is one of my favorites. I prepare a tossed green salad while the pasta cooks and serve up a lovely light supper in minutes!',
  charity_id: '0620048',
  charity_name: 'FRIENDS OF THE NATIONAL MULTIPLE SCLEROSIS SOCIETY',
  avg_rating: 4.7
)
user4.recipes.first.ingredients.create!([
  { name: 'linguine', amount: '1 16-oz package' },
  { name: 'fresh or frozen peas', amount: '1/2 cup' },
  { name: 'garlic, minced', amount: '2 tbsp' },
  { name: 'italian seasoning', amount: '1 tbsp' },
  { name: 'olive oil', amount: '1/4 cup' },
  { name: 'pepper', amount: '1 tsp' },
  { name: 'thin sliced prosciutto', amount: '1/2 lbs' },
  { name: 'shredded parmesan', amount: '1/4 cup' }
  ])
user4.recipes.first.instructions.create!([
  { description: "Cook linguine according to package directions, adding peas during the last 3 minutes. Meanwhile, in a large cast-iron or other heavy skillet, saute garlic, Italian seasoning and pepper in oil until garlic is tender, about 1 minute. Stir in prosciutto." },
  { description: "Drain linguine; add to skillet and toss to coat. Sprinkle with cheese." },
  ])

user5.recipes.create!(
  image: 'https://www.seriouseats.com/2020/07/20200706-chorizo-egg-refried-bean-breakfast-burrito-daniel-gritzer-30.jpg',
  title: 'Breakfast Burritos',
  description: 'The best way to start your morning is with this amazing burrito. It got me through college!',
  charity_id: '012312',
  charity_name: 'Amnesty International USA',
  avg_rating: 4.6
)
user5.recipes.first.ingredients.create!([
  { name: 'Avocado', amount: '1' },
  { name: 'Tomatoes, diced', amount: '1/2 cup' },
  { name: 'Onion', amount: '1' },
  { name: 'Garlic, minced', amount: '1' },
  { name: 'Lime Juice', amount: '1 tbsp' },
  { name: 'Eggs', amount: '4' },
  { name: 'Sausage', amount: '1/2 lb' },
  { name: 'Mexican cheese', amount: '1 1/3 cups' },
  { name: 'Tortialls', amount: '4' },
  { name: 'Vegitable oil', amount: 'for cooking' }
])
user5.recipes.first.instructions.create!([
  { description: "Make the Avocado-Tomato Salsa: Place all of the ingredients in a medium bowl and mix to combine. Set aside." },
  { description: "In a medium bowl, whisk the eggs with the smoked paprika and salt. Set aside." },
  { description: "Heat a large nonstick pan over medium-high heat. Add the sausage and cook, stirring frequently, until browned, 4 to 5 minutes. Use a slotted spoon to transfer the sausage from the pan to a plate, leaving the drippings in the pan." },
  { description: "Reduce the heat to low. Add the eggs and scramble until just cooked through. Transfer the eggs to a plate. Clean the pan (you'll use it again)." },
  { description: "Assemble the burritos: Spoon about 1/4 cup of the avocado-salsa onto each tortilla (you'll have a little leftover salsa; that's for the cook!), followed by a quarter of the sausage, a quarter of the eggs, and 1/3 cup cheese. Fold in the sides of the tortilla over the filling and roll, tucking in the edges as you go." },
  { description: "Lightly coat the pan with oil and set over medium heat. When the pan is hot, add the burritos, seam side down. Cook, covered, until the bottom of the burritos are golden brown, about 3 minutes. Flip the burritos over and continue cooking, covered, until golden, a few minutes more. Serve warm." },
  { description: "Make Ahead: The burritos may be assembled a few hours ahead of time, wrapped tightly in plastic wrap and refrigerated, before cooking. To reheat leftover burritos, wrap in foil and warm in a 350°F oven for about 15 minutes. (They won't be as crisp as they are fresh out of the pan, but they reheat well.)" },
  ])

user6.recipes.create!(
  image: 'https://wishesndishes.com/images/2013/10/Homemade-Hamburger-Helper-Recipe-2.jpg',
  title: 'Homemade Hamburger Helper',
  description: 'Trust me, its better than the box kind. It will be a new family go to.',
  charity_id: '3234873',
  charity_name: 'The Trevor Project',
  avg_rating: 2.8
)
user6.recipes.first.ingredients.create!([
  { name: 'ground beef', amount: '1 lb' },
  { name: 'cooking spray', amount: 'as needed' },
  { name: 'milk', amount: '2 cups' },
  { name: 'cornstarch', amount: '1 tbsp' },
  { name: 'chili powder', amount: '1 tsp' },
  { name: 'garlic powder', amount: '2 tsp' },
  { name: 'sugar', amount: '1 tsp' },
  { name: 'paprika', amount: '3/4 tsp' },
  { name: 'cayenne pepper', amount: '1/4 tsp' },
  { name: 'chedder cheese', amount: '2 cups' }
])
user6.recipes.first.instructions.create!([
  { description: "Heat a large skilletover medium-high heat. Spray with cooking spray and add the ground beef. Brown until cooked through and no longer pink. Discard any fat" },
  { description: "Add the pasta, milk, water and spices and stir to combine. Bring to a boil and turn the heat down to simmer. Cover and cook for 10-12 minutes, or until the pasta is al dente" },
  ])

user7.recipes.create!(
  image: 'https://i0.wp.com/www.moonsandspoons.com/wp-content/uploads/2015/01/LentilSoup.jpeg?ssl=1',
  title: 'Sooth Lentil Soup',
  description: 'Best for a day when you need that extra comfort. I learned this recipe from my mom when moving out for college and always made it right before an exam.',
  charity_id: '123123',
  charity_name: 'American Cancer Society',
  avg_rating: 4.0
)
user7.recipes.first.ingredients.create!([
  { name: 'olive oil', amount: '2 tablespoons' },
  { name: 'medium onion', amount: '1' },
  { name: 'ginger/garlic paste', amount: '1 tablespoon' },
  { name: 'salt', amount: '3/4 tsp' },
  { name: 'cumin', amount: '1 tsp' },
  { name: 'red lentils', amount: '1 cup' },
  { name: 'carrots', amount: '2' },
  { name: 'red potatoes', amount: '4' },
  { name: 'chicken broth', amount: '4 cups' },
  { name: 'lemon juice', amount: '2' },
  { name: 'parsley', amount: '2 tablespoons' }
])
user7.recipes.first.instructions.create!([
  { description: "Heat the oil in pot over medium heat. Then add the onions and then sautée until slightly brown, about 7-10 minutes." },
  { description: "Add the ginger-garlic paste and sautée about 1 minute. Add the cumin and salt and sautee about 1 minute." },
  { description: "Add lentils, carrots, potatoes, and chicken broth. Bring to boil and then turn down to a rolling simmer. Simmer for 25 minutes, until vegetables are soft." },
  { description: "Take one cup of the soup and emulsify it in a blender. Mix the blended cup back in the pot." },
  { description: "Add lemon juice to the pot. Cook for another 5 mins. Add the parsley right before you serve." },
  ])

user8.recipes.create!(
  image: 'https://cdn10.bostonmagazine.com/wp-content/uploads/sites/2/2018/11/dumplings-social.jpg',
  title: 'BDD - Best Dang Dumplings!',
  description: 'Ever hear the saying, good things come to those who wait? Well if you have the patience to make this, then you in for the ride of your life.',
  charity_id: '84734',
  charity_name: 'AARP',
  avg_rating: 5.0
)
user8.recipes.first.ingredients.create!([
  { name: 'ground chicken', amount: '1/2 pound' },
  { name: 'green onion', amount: '1/4 cup' },
  { name: 'napa cappage', amount: '1/4 cup' },
  { name: 'soy sauce', amount: '2 tsp' },
  { name: 'sesame oil', amount: '2 tsp' },
  { name: 'ground ginger', amount: '1 1/2 tsp' },
  { name: 'dumpling wrappers', amount: '1 pack' }
])
user8.recipes.first.instructions.create!([
  { description: "To shred the Napa cabbage, use a food processor or high speed blender and pulse." },
  { description: "In a bowl, combine all of the ingredients except the wrappers." },
  { description: "Take a dumpling wrapper and place a spoonful of filling in the center, about a teaspoons worth." },
  { description: "Dip your finger in the bowl of water and spread it around the edges of the wrapper. Fold the wrapper in half and pinch the sides together to create a seal. Place the finished dumplings on a floured surface or on parchment paper so they don’t stick." },
  { description: "Bring a pot of water to boil. Boil the dumplings until they float–this means they’re done." },
  { description: "If desired, heat the sesame oil on high and quickly pan fry the dumplings after boiling for extra flavor and a little more texture." },
  { description: "Serve hot with a drizzle of soy sauce and sprinkle of green onions." },
  ])

user1.user_recipes.create!(recipe_id: user3.recipes.first.id, amount_donated: 3.25)

puts "Seeded and Ready to Roll!"
