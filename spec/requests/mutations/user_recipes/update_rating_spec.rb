require 'rails_helper'

RSpec.describe 'UserRecipe Update' do
  before :each do
    FactoryBot.create :user
    FactoryBot.create(:recipe, user_id: User.first.id)
    User.first.user_recipes.create!(recipe: Recipe.first, amount_donated: 2.25)
    @recipe_id = UserRecipe.last.id
  end

  describe 'happy-paths' do
    it 'updates rating' do
      query_string = <<-GRAPHQL
        mutation {
          updateRating(input: { params: { id: #{@recipe_id}, recipeRating: 3 } }) {
            userRecipe {
              id
              recipeRating
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data]).to have_key(:updateRating)
      expect(results[:data][:updateRating]).to be_a(Hash)
      expect(results[:data][:updateRating]).to have_key(:userRecipe)
      expect(results[:data][:updateRating][:userRecipe]).to be_a(Hash)
      expect(results[:data][:updateRating][:userRecipe]).to have_key(:id)
      expect(results[:data][:updateRating][:userRecipe][:id]).to be_a(String)
      expect(results[:data][:updateRating][:userRecipe]).to have_key(:recipeRating)
      expect(results[:data][:updateRating][:userRecipe][:recipeRating]).to be_a(Integer)
    end
  end

  describe 'sad-paths' do
    it 'cannot update if rating is 0 or below' do
      query_string = <<-GRAPHQL
        mutation {
          updateRating(input: { params: { id: #{@recipe_id}, recipeRating: 0 } }) {
            userRecipe {
              id
              recipeRating
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:errors].first[:message]).to eq("Rating must be and integer between 0 and 5.")
    end

    it 'cannot update if rating is higher than 5' do
      query_string = <<-GRAPHQL
        mutation {
          updateRating(input: { params: { id: #{@recipe_id}, recipeRating: 6 } }) {
            userRecipe {
              id
              recipeRating
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:errors].first[:message]).to eq("Rating must be and integer between 0 and 5.")
    end

    it 'cannot update with non-existing id' do
      query_string = <<-GRAPHQL
        mutation {
          updateRating(input: { params: { id: 9, recipeRating: 3 } }) {
            userRecipe {
              id
              recipeRating
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:errors].first[:message]).to eq("No record of UserRecipe with ID 9")
    end
  end
end
