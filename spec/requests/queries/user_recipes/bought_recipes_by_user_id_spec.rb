require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @user = create(:user, :with_recipes)
      @recipe_one = @user.recipes.first
      @recipe_two = @user.recipes.last
      @buyer = create(:user)
      @user_recipe_one = UserRecipe.create(user_id: @buyer.id, recipe_id: @recipe_one.id, amount_donated: 5.50)
      @user_recipe_two = UserRecipe.create(user_id: @buyer.id, recipe_id: @recipe_two.id, amount_donated: 1.00)
      @ingredient_one = create(:ingredient, recipe_id: @recipe_one.id)
      @ingredient_two = create(:ingredient, recipe_id: @recipe_two.id)
    end

    def query(userId:)
      <<~GQL
        query {
          boughtRecipesByUser( userId: #{userId} ) { 
            id
            userId
            recipeId
            recipe {
              id
              image
              title
              description
              instructions
              charityId
              userId
              avgRating
              ingredients {
                id
                name
                amount
              }
            }
          }
        }
      GQL
    end

    it 'cannot get all of a users bought recipes with an user that doesnt exist' do
      post '/graphql', params: { query: query(userId: 12345) }

      json = JSON.parse(response.body)

      expect(json['errors'][0]['message']).to eq("No record of User with ID 12345")
    end
  end
end
