require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'relationships' do
    it { should have_many :user_recipes }
    xit { should have_many :ingredients }
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :instructions }
    xit { should validate_presence_of :charity_id }
  end

  describe 'class-methods' do
    it 'can update average rating' do
      seller = User.create!(username: 'Bob', password: '123')
      recipe = seller.recipes.create!(title: 'Pea Soup', description: 'Yum', instructions: '123')

      expect(recipe.avg_rating).to eq(nil)

      buyer_1 = User.create!(username: 'Bill', password: '123')
      buyer_1.user_recipes.create!(recipe: recipe, amount_donated: 2.35, recipe_rating: 4.5)
      Recipe.update_rating(recipe.id)
      expect(Recipe.find(recipe.id).avg_rating).to eq(4.5)

      buyer_2 = User.create!(username: 'Ted', password: '123')
      buyer_2.user_recipes.create!(recipe: recipe, amount_donated: 1.25, recipe_rating: 3.25)
      Recipe.update_rating(recipe.id)
      expect(Recipe.find(recipe.id).avg_rating).to eq(3.9)
    end
  end
end
