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
          boughtRecipesByUser(
            userId: #{userId}
          ) { 
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

    it 'can get all of a users bought recipes' do
      post '/graphql', params: { query: query(userId: @buyer.id) }

      json = JSON.parse(response.body)

      expect(json['data']['boughtRecipesByUser'][0]['id']).to eq(@user_recipe_one.id.to_s)
      expect(json['data']['boughtRecipesByUser'][0]['userId']).to eq(@buyer.id.to_s)
      expect(json['data']['boughtRecipesByUser'][0]['recipeId']).to eq(@recipe_one.id.to_s)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['id']).to eq(@recipe_one.id.to_s)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['image']).to eq(@recipe_one.image)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['title']).to eq(@recipe_one.title)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['description']).to eq(@recipe_one.description)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['instructions']).to eq(@recipe_one.instructions)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['charityId']).to eq(@recipe_one.charity_id.to_s)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['userId']).to eq(@user.id.to_s)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['avgRating']).to eq(@recipe_one.avg_rating)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['ingredients']).to be_an(Array)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['ingredients'][0]['id']).to eq(@ingredient_one.id.to_s)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['ingredients'][0]['name']).to eq(@ingredient_one.name)
      expect(json['data']['boughtRecipesByUser'][0]['recipe']['ingredients'][0]['amount']).to eq(@ingredient_one.amount)

      expect(json['data']['boughtRecipesByUser'][1]['id']).to eq(@user_recipe_two.id.to_s)
      expect(json['data']['boughtRecipesByUser'][1]['userId']).to eq(@buyer.id.to_s)
      expect(json['data']['boughtRecipesByUser'][1]['recipeId']).to eq(@recipe_two.id.to_s)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['id']).to eq(@recipe_two.id.to_s)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['image']).to eq(@recipe_two.image)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['title']).to eq(@recipe_two.title)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['description']).to eq(@recipe_two.description)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['instructions']).to eq(@recipe_two.instructions)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['charityId']).to eq(@recipe_two.charity_id.to_s)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['userId']).to eq(@user.id.to_s)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['avgRating']).to eq(@recipe_two.avg_rating)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['ingredients']).to be_an(Array)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['ingredients'][0]['id']).to eq(@ingredient_two.id.to_s)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['ingredients'][0]['name']).to eq(@ingredient_two.name)
      expect(json['data']['boughtRecipesByUser'][1]['recipe']['ingredients'][0]['amount']).to eq(@ingredient_two.amount)
    end
  end
end
