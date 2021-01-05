require 'rails_helper'

RSpec.describe UserRecipe, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :recipe }
  end

  describe 'instantiation' do
    before :each do
      @seller = User.create!(username: 'Bob', password: '123')
      @buyer = User.create!(username: 'Bill', password: '123')
    end

    it 'should be able to create a user recipe' do
      recipe = @seller.recipes.create!(title: 'Pea Soup', description: 'Yum', instructions: '123')
      @buyer.user_recipes.create!(recipe: recipe, amount_donated: 1.25, recipe_rating: 4)
      expect(UserRecipe.count).to eq(1)
    end

    it 'cannot create user recipe with missing recipe' do
      expect{@buyer.user_recipes.create!(amount_donated: 1.25, recipe_rating: 4)}
        .to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'cannot create user recipe with missing user' do
      recipe = @seller.recipes.create!(title: 'Pea Soup', description: 'Yum', instructions: '123')
      expect{UserRecipe.create!(recipe: recipe, amount_donated: 1.25, recipe_rating: 4)}
        .to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
