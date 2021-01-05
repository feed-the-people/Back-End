require 'rails_helper'
module Mutations
  module UserRecipes
    RSpec.describe CreateUserRecipe, type: :request do
      before :each do 
        @user = create(:user, :with_recipes)
        @recipe = @user.recipes.first
      end
      def query(recipeId:, userId:, amountDonated:)
        <<~GQL
          mutation {
            createUserRecipe(input: { params: {
              recipeId: #{recipeId}
              userId: #{userId}
              amountDonated: "#{amountDonated}"
            }}) {
              amountDonated
            }
          }
        GQL
      end

      it 'A user recipe can be created' do
        post '/graphql', params: { query: query(recipeId: @recipe.id.to_s, userId: @user.id.to_s, amountDonated: "2.50".to_s) }

        json = JSON.parse(response.body)
        require 'pry'; binding.pry
        expect(json['data']['createUserRecipe']['id']).to_not eq(nil)

        expect(json['data']['createUserRecipe']['recipeId']).to be_a(String)
        expect(json['data']['createUserRecipe']['recipeId']).to eq(@recipe.id.to_s)

        expect(json['data']['createUserRecipe']['userId']).to be_a(String)
        expect(json['data']['createUserRecipe']['userId']).to eq(@user.id.to_s)

        expect(json['data']['createUserRecipe']['amountDonated']).to be_a(String)
        expect(json['data']['createUserRecipe']['amountDonated']).to eq("2.50")

        expect(json['data']['createUserRecipe']['recipeRating']).to eq(nil)
      end
    end
  end
end