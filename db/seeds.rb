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

FactoryBot.create_list(:user, 2)

4.times do 
  FactoryBot.create(:recipe, user_id: 1)
end

i = 1
4.times do
  3.times do 
    FactoryBot.create(:ingredient, recipe_id: i)
  end
  i += 1
end

User.last.user_recipes.create!(recipe: Recipe.first, amount_donated: 2.50)

puts "Seeded and Ready to Roll!"