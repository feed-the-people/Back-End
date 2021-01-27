require 'rails_helper'

RSpec.describe 'createRecipe endpoint' do
  before :each do
    FactoryBot.create :user
  end

  describe 'happy-path' do
    it 'returns a recipe with all needed args' do
      params = <<-GRAPHQL
          {
    	"params": { "params": {
         "userId": #{User.first.id},
         "title": "Chicken Parmesan",
         "image": "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2019/7/11/0/FNK_the-best-chicken-parmesan_H_s4x3.jpg.rend.hgtvcom.826.620.suffix/1562853897238.jpeg",
         "description": "A classic favorite!",
         "instructions": [{"description": "1. chicken"}, {"description": "2. ???"}, {"description": "3. Profit"}],
         "charityId": "533423",
         "charityName": "Cookies for Kevin Fund",
         "ingredients": [{"name": "Chicken", "amount": "2 lbs"},{"name": "Parmesan", "amount": "5 gallons"}]
      }}

    }
      GRAPHQL

      query_string = <<-GRAPHQL
        mutation($params: CreateRecipeInput!) {
          createRecipe(input: $params) {
            recipe {
              id
              title
              description
              instructions {
                description
              }
              ingredients {
                name
                amount
              }
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string, variables: params}

      results = JSON.parse(response.body, symbolize_names: true)
      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data]).to have_key(:createRecipe)
      expect(results[:data][:createRecipe]).to be_a(Hash)
      expect(results[:data][:createRecipe]).to have_key(:recipe)

      recipe = results[:data][:createRecipe][:recipe]

      expect(recipe).to be_a(Hash)
      expect(recipe).to have_key(:id)
      expect(recipe[:id]).to be_a(String)
      expect(recipe).to have_key(:title)
      expect(recipe[:title]).to be_a(String)
      expect(recipe).to have_key(:description)
      expect(recipe[:description]).to be_a(String)
      expect(recipe).to have_key(:instructions)
      expect(recipe[:instructions]).to be_an(Array)
      expect(recipe).to have_key(:ingredients)
      expect(recipe[:ingredients]).to be_an(Array)
      expect(recipe[:ingredients].count).to eq(2)

      ingredients = recipe[:ingredients]

      ingredients.each do |ingredient|
        expect(ingredient).to have_key(:name)
        expect(ingredient[:name]).to be_a(String)
        expect(ingredient).to have_key(:amount)
        expect(ingredient[:amount]).to be_a(String)
      end
      
      instructions = recipe[:instructions]
      instructions.each do |instruction|
        expect(instruction).to have_key(:description)
        expect(instruction[:name]).to be_a(String)
      end
    end
  end
end
