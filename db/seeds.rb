# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

UserRecipe.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
User.destroy_all

FactoryBot.create_list(:user, 4)

User.create!(
  image: 'uziope8q2ur0k7ht2x4q',
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

user2 = User.second
user3 = User.third
user4 = User.fourth
user5 = User.fifth

user2.recipes.create!(
  image: 'ut1rblpvcrqvjavqdykz',
  title: 'Easy Stir-Fry',
  description: 'This easy stir-fry recipe is ideal for quick and easy weeknight dinners. Once you master the basic formula, you can make endless variations!',
  instructions: "1. Make stir-fry sauce. Your sauce melds together all the different flavors and textures of the protein and vegetables in the stir-fry. For this recipe, the sauce is sweet and tangy. In a small bowl, combine cornstarch, orange juice, soy sauce, garlic and ginger until smooth; set aside.\n\n2. Sear the meat. The meat or protein cooks first, seasoning the fat in the skillet. In a large skillet or wok, stir-fry pork in oil until lightly browned, 5 minutes; drain.\n\n3. Toss in veggies. Whatever veggies you’re using go in next. Whatever you’re using, make sure to cut everything to the same size. Here, add the onion, peas and red pepper; cook and stir until crisp-tender, 3-5 minutes.\n\n4. Add sauce. Cooking the sauce for a few minutes allows it to thicken up. Stir orange juice mixture and add to the pan. Bring to a boil; cook and stir until thickened, about 2 minutes.\n\n5. Serve with carb of choice. Stir-fries are so full of flavor, they’re usually served on top of a plain base, which absorbs flavor from the sauce. We like to serve this with rice, rice noodles, zoodles or steamed vegetables.",
  charity_id: '4593516',
  charity_name: 'HUNGRY NO MORE'
)
user2.recipes.first.ingredients.create!([
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

user3.recipes.create!(
  image: 'dsgs8fnuwmjyr07zyb7l',
  title: 'The Best Fish-Tacos',
  description: 'I like to pair pan-fried tilapia with a cool and creamy slaw for a flavorful fish taco recipe—easy and delicious! The simple, nutritious ingredients and kid-friendly taste make this Mexican-inspired dish a perfect weeknight dinner.',
  instructions: "1. In a large bowl, whisk together mayonnaise, sour cream, lime juice, honey, salt and pepper. Add coleslaw mix or shredded cabbage and gently toss to coat. Cover and refrigerate for at least 30 minutes, or up to 8 hours.\n\n2. In a shallow dish, combine flour, taco seasoning, salt and pepper. Add the tilapia and lightly coat on both sides. Heat oil in a large skillet over medium-high heat. Shake excess flour off of the tilapia and place in the skillet. Brown fish on both sides (about 2-3 minutes per side). Flake into large chunks.\n\n3. Toast the corn tortillas in a dry skillet over medium heat for about 30 seconds per side. Alternatively, you can wrap the tortillas in stacks of five in foil and warm in a 350°F oven for 10-15 minutes (or until heated through).\n\n4. Fill each warm tortilla with flaked tilapia, slaw and other toppings of choice.",
  charity_id: '0545998',
  charity_name: 'SALVATION ARMY'
)
user3.recipes.first.ingredients.create!([
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

user4.recipes.create!(
  image: 'bdukyzppfxzdnnkqlljb',
  title: 'Mothers Meat Balls',
  description: 'Wondering what the secret is to making gorgeous, tender meatballs in a cinch? My easy meatball recipe shows you how to whip up this delicious comfort food quickly.',
  instructions: "1. Pour the eggs, onion, garlic, water, breadcrumbs, Parmesan and seasonings into a large bowl. Whisk it well until all of the ingredients are evenly dispersed. The eggs and breadcrumbs are essential for binding the meat. Thanks to their moisture content, eggs help keep your meatballs lovely and tender.\n\n2. Crumble the ground beef into the egg mixture. Use your hands to combine everything but do not overwork the beef. I can’t stress this enough! If you overdo it, you run the risk of tough meatballs. Instead, gently work the mix until it’s just combined. Once you’re happy with the beef mixture, lightly shape the meatballs to be about 1 to 1 ½ inches. You can make larger meatballs, if you choose.\n\n3. Grease a rack and place it in a shallow baking tray. I pour a little olive oil onto a paper towel and rub the rack down, but a nonstick cooking spray would work here. Arrange the meatballs, and then put them in the oven. Bake at 375° for about 15 to 18 minutes, or until your instant-read thermometer says they’re cooked through (160-165°).",
  charity_id: '6048381',
  charity_name: 'DENVER FOUNDATION'
)
user4.recipes.first.ingredients.create!([
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

user5.recipes.create!(
  image: 'ee6kzz7q8fu62zth70mz',
  title: 'Prosciutto Pasta Toss',
  description: 'I love quick, simple dishes, and this pasta with prosciutto and peas is one of my favorites. I prepare a tossed green salad while the pasta cooks and serve up a lovely light supper in minutes!',
  instructions: '1. Cook linguine according to package directions, adding peas during the last 3 minutes. Meanwhile, in a large cast-iron or other heavy skillet, saute garlic, Italian seasoning and pepper in oil until garlic is tender, about 1 minute. Stir in prosciutto.\n\n2. Drain linguine; add to skillet and toss to coat. Sprinkle with cheese.',
  charity_id: '0620048',
  charity_name: 'FRIENDS OF THE NATIONAL MULTIPLE SCLEROSIS SOCIETY'
)
user5.recipes.first.ingredients.create!([
  { name: 'linguine', amount: '1 16-oz package' },
  { name: 'fresh or frozen peas', amount: '1/2 cup' },
  { name: 'garlic, minced', amount: '2 tbsp' },
  { name: 'italian seasoning', amount: '1 tbsp' },
  { name: 'olive oil', amount: '1/4 cup' },
  { name: 'pepper', amount: '1 tsp' },
  { name: 'thin sliced prosciutto', amount: '1/2 lbs' },
  { name: 'shredded parmesan', amount: '1/4 cup' }
  ])

puts "Seeded and Ready to Roll!"
