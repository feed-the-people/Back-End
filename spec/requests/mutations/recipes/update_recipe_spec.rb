require 'rails_helper'

RSpec.describe 'Update Recipe' do
  before :each do
    @user = create(:user)
    @recipe = create(:recipe, user_id: @user.id, title: "Chicken Parmesan", description: "A classic favorite!", instructions: "1. chicken 2.???? 3. profit", charity_id: 533423, charity_name: "Boys & Girls Club", ingredients: [{ name: "Chicken" amount: "2 lbs" }, { name: "Parmesan" amount: "5 lbs" }])
  end

  describe 'happy-paths' do
    it 'updates recipe attributes' do
      mutation_string = <<-GRAPHQL
        mutation {
          updateRecipe(input: { params: {
            userId: #{@user.id}
            title: "Spaghetti"
            description: "il classico è molto delizioso"
            instructions: "1. Noodles! 2. Italian Sausage and Veggies! 3. Basil Sauce! 4. Yum!"
            ingredients: [{ name: "Spaghetti Noodles" amount: "1 lb" }, { name: "Italian Sausage" amount: "2 lbs" }, { name: "Basil Sauce" amount: "2 cans" }]
          }) {
            recipe {
              id
              title
              description
              instructions
              ingredients {
                name
                amount
              }
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: mutation_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data]).to have_key(:updateRecipe)
      expect(results[:data][:updateRecipe]).to be_a(Hash)
      expect(results[:data][:updateRecipe]).to have_key(:recipe)
    end
  end
