require 'rails_helper'

RSpec.describe 'allRecipes endpoint' do
  before :each do
    FactoryBot.create_list :user, 2
    FactoryBot.create(:recipe, user_id: User.first.id)
    FactoryBot.create(:recipe, user_id: User.last.id)
  end

  describe 'happy-path' do
    it 'gets all recipes in desc createdAt order' do
      query_string = <<-GRAPHQL
        query {
          allRecipes {
            id
            title
            description
            instructions
            image
            avgRating
            userId
            charityId
            createdAt
            updatedAt
        }
      }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data]).to have_key(:allRecipes)
      expect(results[:data][:allRecipes]).to be_an(Array)
      expect(results[:data][:allRecipes].length).to eq(2)

      all_recipes = results[:data][:allRecipes]

      all_recipes.each do |recipe|
        expect(recipe).to have_key(:id)
        expect(recipe).to have_key(:title)
        expect(recipe).to have_key(:description)
        expect(recipe).to have_key(:instructions)
        expect(recipe).to have_key(:image)
        expect(recipe).to have_key(:avgRating)
        expect(recipe).to have_key(:userId)
        expect(recipe).to have_key(:charityId)
        expect(recipe).to have_key(:createdAt)
        expect(recipe).to have_key(:updatedAt)
      end
    end
  end

  describe 'sad-path' do
    it 'cannot query field that does not exist' do
      query_string = <<-GRAPHQL
        query {
          allRecipes {
            babaganoush
        }
      }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:errors].first[:message]).to eq("Field 'babaganoush' doesn't exist on type 'Recipe'")
    end
  end
end
