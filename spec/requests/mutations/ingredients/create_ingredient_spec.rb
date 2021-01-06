require 'rails_helper'

RSpec.describe 'createIngredient endpoint' do
  before :each do
    FactoryBot.create :user
    FactoryBot.create(:recipe, user_id: User.first.id)
    FactoryBot.create(:ingredient, recipe: Recipe.first)
  end

  describe 'happy-path' do
    it 'returns an ingredient after creation' do
      query_string = <<-GRAPHQL
        mutation {
          createIngredient( input: { params: { recipeId: #{Recipe.first.id} name: "Oats" amount: "1 tsp" }}) {
            ingredient {
                name
                amount
              }
            }
          }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data]).to have_key(:createIngredient)
      expect(results[:data][:createIngredient]).to be_a(Hash)
      expect(results[:data][:createIngredient]).to have_key(:ingredient)

      ingredient = results[:data][:createIngredient][:ingredient]
      expect(ingredient).to have_key(:name)
      expect(ingredient[:name]).to be_a(String)
      expect(ingredient).to have_key(:amount)
      expect(ingredient[:amount]).to be_a(String)
    end
  end

  describe 'sad-path' do
    it 'recipe doesnt exist in database' do
      query_string = <<-GRAPHQL
        mutation {
          createIngredient( input: { params: { recipeId: 9999 name: "Oats" amount: "1 tsp" }}) {
            ingredient {
                name
                amount
              }
            }
          }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results[:errors].first[:message]).to eq("No record of Recipe with ID 9999")
    end
  end
end
