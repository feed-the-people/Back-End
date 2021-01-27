require 'rails_helper'

RSpec.describe 'recipeById endpoint' do
  before :each do
    FactoryBot.create :user
    FactoryBot.create(:recipe, user_id: User.first.id)
    FactoryBot.create_list(:ingredient, 3, recipe: Recipe.first)
  end

  describe 'happy-path' do
    it 'returns a single recipe and all of its fields' do
      query_string = <<-GRAPHQL
        query {
          recipeById(id: #{Recipe.first.id}) {
            id
            title
            description
            instructions {
              description
            }
            image
            userId
            avgRating
            charityId
            charityName
            updatedAt
            createdAt
            ingredients {
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
      expect(results[:data]).to have_key(:recipeById)

      recipe = results[:data][:recipeById]

      expect(recipe).to be_a(Hash)
      expect(recipe).to have_key(:id)
      expect(recipe[:id]).to be_a(String)
      expect(recipe).to have_key(:title)
      expect(recipe[:title]).to be_a(String)
      expect(recipe).to have_key(:description)
      expect(recipe[:description]).to be_a(String)
      expect(recipe).to have_key(:instructions)
      expect(recipe[:instructions]).to be_an(Array)
      expect(recipe).to have_key(:image)
      expect(recipe[:image]).to be_a(String)
      expect(recipe).to have_key(:userId)
      expect(recipe[:userId]).to be_a(String)
      expect(recipe).to have_key(:avgRating)
      expect(recipe[:avgRating]).to be(nil)
      expect(recipe).to have_key(:charityId)
      expect(recipe[:charityId]).to be_a(String)
      expect(recipe).to have_key(:charityName)
      expect(recipe[:charityName]).to be_a(String)
      expect(recipe).to have_key(:updatedAt)
      expect(recipe[:updatedAt]).to be_a(String)
      expect(recipe).to have_key(:createdAt)
      expect(recipe[:createdAt]).to be_a(String)
      expect(recipe).to have_key(:ingredients)

      ingredients = recipe[:ingredients]

      expect(ingredients.count).to eq(3)

      ingredients.each do |ingredient|
        expect(ingredient).to have_key(:name)
        expect(ingredient[:name]).to be_a(String)
        expect(ingredient).to have_key(:amount)
        expect(ingredient[:amount]).to be_a(String)
      end
    end
  end

  describe 'sad-path' do
    it 'record does not exist in database' do
      query_string = <<-GRAPHQL
        query {
          recipeById(id: 9999999) {
            id
            title
            description
            instructions {
              description
            }
            image
            userId
            avgRating
            charityId
            charityName
            updatedAt
            createdAt
            ingredients {
              name
              amount
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:errors].first[:message]).to eq("Recipe does not exist.")
    end

    it 'incorrect argument type' do
      query_string = <<-GRAPHQL
        query {
          recipeById(id: 2.5) {
            id
            title
            description
            instructions {
              description
            }
            image
            userId
            avgRating
            charityId
            charityName
            updatedAt
            createdAt
            ingredients {
              name
              amount
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)
      expect(results[:errors].first[:message]).to eq("Argument 'id' on Field 'recipeById' has an invalid value. Expected type 'ID!'.")
    end

    it 'requested field does not exist' do
      query_string = <<-GRAPHQL
        query {
          recipeById(id: #{Recipe.first.id}) {
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
