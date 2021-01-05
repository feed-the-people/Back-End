require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @user = create(:user, :with_recipes)
      @recipe_one = @user.recipes.first
      @recipe_two = @user.recipes.last
      @buyer = create(:user)
      UserRecipe.create(user_id: @buyer.id, recipe_id: @recipe_one.id, amount_donated: 5.50)
      UserRecipe.create(user_id: @buyer.id, recipe_id: @recipe_two.id, amount_donated: 1.00)
      create(:ingredient, recipe_id: @recipe_one.id)
      create(:ingredient, recipe_id: @recipe_two.id)
    end

    def query(userId:)
      <<~GQL
        query {
          bougthRecipes(
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
              }
          }
        }
      GQL
    end

    it 'can get a single user without any recipes' do
      post '/graphql', params: { query: query(userId: @buyer.id) }

      json = JSON.parse(response.body)
      require 'pry'; binding.pry

      expect(json['data']['userRecipeByUserId'].each do
      expect(json['data']['getUser']['image']).to eq(@user_1.image)
      expect(json['data']['getUser']['username']).to eq(@user_1.username)
      expect(json['data']['getUser']['firstName']).to eq(@user_1.first_name)
      expect(json['data']['getUser']['lastName']).to eq(@user_1.last_name)
      expect(json['data']['getUser']['street']).to eq(@user_1.street)
      expect(json['data']['getUser']['city']).to eq(@user_1.city)
      expect(json['data']['getUser']['state']).to eq(@user_1.state)
      expect(json['data']['getUser']['zip']).to eq(@user_1.zip)
      expect(json['data']['getUser']['recipes']).to eq([])
    end

    # it 'can get a single user with some recipes' do
    #   post '/graphql', params: { query: query(id: @user_2.id) }

    #   json = JSON.parse(response.body)

    #   expect(json['data']['getUser']['id']).to eq(@user_2.id.to_s)
    #   expect(json['data']['getUser']['image']).to eq(@user_2.image)
    #   expect(json['data']['getUser']['username']).to eq(@user_2.username)
    #   expect(json['data']['getUser']['firstName']).to eq(@user_2.first_name)
    #   expect(json['data']['getUser']['lastName']).to eq(@user_2.last_name)
    #   expect(json['data']['getUser']['street']).to eq(@user_2.street)
    #   expect(json['data']['getUser']['city']).to eq(@user_2.city)
    #   expect(json['data']['getUser']['state']).to eq(@user_2.state)
    #   expect(json['data']['getUser']['zip']).to eq(@user_2.zip)
    #   expect(json['data']['getUser']['recipes'].size).to eq(3)
    #   expect(json['data']['getUser']['recipes']).to match_array(
    #     @user_2.recipes.map do |recipe|
    #       { 'id' => recipe.id.to_s }
    #     end
    #   )
    # end
  end
end
