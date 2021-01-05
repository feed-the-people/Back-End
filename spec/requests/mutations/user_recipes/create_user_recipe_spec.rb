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
              userRecipe {
                id
                userId
                recipeId
                amountDonated
                recipeRating
                createdAt
                updatedAt
              }
            }
          }
        GQL
      end

      def sad_path_query(recipeId:, userId:, badParam:)
        <<~GQL
          mutation {
            createUserRecipe(input: { params: {
              recipeId: #{recipeId}
              userId: #{userId}
              badParam: "#{badParam}"
            }}) {
              id
            }
          }
        GQL
      end

      def another_sad_query(recipeId:, userId:, amountDonated:, recipeRating:)
        <<~GQL
          mutation {
            createUserRecipe(input: { params: {
              recipeId: #{recipeId}
              userId: #{userId}
              recipeRating: #{recipeRating}
              amountDonated: "#{amountDonated}"
            }}) {
              id
            }
          }
        GQL
      end

      describe 'happy paths' do
        it 'A user recipe can be created' do
          post '/graphql', params: { query: query(recipeId: @recipe.id.to_s, userId: @user.id.to_s, amountDonated: "2.50") }

          json = JSON.parse(response.body)

          expect(json['data']['createUserRecipe']['userRecipe']['id']).to_not eq(nil)

          expect(json['data']['createUserRecipe']['userRecipe']['recipeId']).to be_a(String)
          expect(json['data']['createUserRecipe']['userRecipe']['recipeId']).to eq(@recipe.id.to_s)

          expect(json['data']['createUserRecipe']['userRecipe']['userId']).to be_a(String)
          expect(json['data']['createUserRecipe']['userRecipe']['userId']).to eq(@user.id.to_s)

          expect(json['data']['createUserRecipe']['userRecipe']['amountDonated']).to be_a(Float)
          expect(json['data']['createUserRecipe']['userRecipe']['amountDonated']).to eq(2.50)

          expect(json['data']['createUserRecipe']['userRecipe']['recipeRating']).to eq(nil)

          expect(UserRecipe.all.size).to eq(1)
        end
      end

      describe 'sad paths' do
        it 'A user recipe cannot be created without amountDonated' do
          post '/graphql', params: { query: sad_path_query(recipeId: @recipe.id.to_s, userId: @user.id.to_s, badParam: "3.50") }

          json = JSON.parse(response.body)

          expect(json['errors'][0]['message']).to eq("Argument 'amountDonated' on InputObject 'CreateInput' is required. Expected type String!")
          
          expect(json['errors'][1]['message']).to eq("InputObject 'CreateInput' doesn't accept argument 'badParam'")

          expect(UserRecipe.all.size).to eq(0)
        end

        it 'A user recipe cannot be created with a recipeId that doesnt exists' do
          post '/graphql', params: { query: query(recipeId: "234312", userId: @user.id.to_s, amountDonated: "3.50") }

          json = JSON.parse(response.body)

          expect(json['errors'][0]['message']).to eq("No record of Recipe with ID 234312")

          expect(UserRecipe.all.size).to eq(0)
        end

        it 'A user recipe cannot be created with a userId that doesnt exists' do
          post '/graphql', params: { query: query(recipeId: @recipe.id.to_s, userId: "2341", amountDonated: "3.50") }

          json = JSON.parse(response.body)

          expect(json['errors'][0]['message']).to eq("No record of User with ID 2341")

          expect(UserRecipe.all.size).to eq(0)
        end

        it 'A user recipe cannot be created with a rating' do
          post '/graphql', params: { query: another_sad_query(recipeId: @recipe.id.to_s, userId: @user.id.to_s, amountDonated: "3.50", recipeRating: "3") }

          json = JSON.parse(response.body)

          expect(json['errors'][0]['message']).to eq("InputObject 'CreateInput' doesn't accept argument 'recipeRating'")

          expect(UserRecipe.all.size).to eq(0)
        end
      end
    end
  end
end