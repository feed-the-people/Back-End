require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'relationships' do
    it { should have_many :user_recipes }
    it { should have_many :ingredients }
    it { should have_many :instructions }
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :charity_id }
    it { should validate_presence_of :charity_name }
  end

  describe 'class-methods' do
    it 'can update average rating' do
      seller = User.create!(username: 'Bob', password: '123')
      recipe = FactoryBot.create(:recipe, user_id: seller.id)

      expect(recipe.avg_rating).to eq(nil)

      buyer_1 = User.create!(username: 'Bill', password: '123')
      buyer_1.user_recipes.create!(recipe: recipe, amount_donated: 2.35, recipe_rating: 4)
      Recipe.update_rating(recipe.id)
      expect(Recipe.find(recipe.id).avg_rating).to eq(4.0)

      buyer_2 = User.create!(username: 'Ted', password: '123')
      buyer_2.user_recipes.create!(recipe: recipe, amount_donated: 1.25, recipe_rating: 3)
      Recipe.update_rating(recipe.id)
      expect(Recipe.find(recipe.id).avg_rating).to eq(3.5)

      buyer_3 = User.create!(username: 'Mike', password: '123')
      buyer_3.user_recipes.create!(recipe: recipe, amount_donated: 5.55)
      Recipe.update_rating(recipe.id)
      expect(Recipe.find(recipe.id).avg_rating).to eq(3.5)
    end
  end
end
