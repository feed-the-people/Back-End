require 'rails_helper'

RSpec.describe 'Update Recipe' do
  before :each do
    @user = create(:user)
    @recipe = create(:recipe, user_id: @user.id, title: "Chicken Parmesan", description: "A classic favorite!", instructions: "1. chicken 2.???? 3. profit", charity_id: "533423", charity_name: "Boys & Girls Club")
  end

  describe 'happy-paths' do
    it 'updates recipe attributes' do
      mutation_string = <<-GRAPHQL
        mutation {
          updateRecipe(input: {params: {
            id: #{@recipe.id},
            userId: #{@user.id},
            title: "Spaghetti",
            description: "il classico è molto delizioso",
            instructions: "1. Noodles! 2. Italian Sausage and Veggies! 3. Basil Sauce! 4. Yum!",
            ingredients: [{ name: "Spaghetti Noodles", amount: "1 lb"}, {name: "Italian Sausage", amount: "2 lbs"}, {name: "Basil Sauce", amount: "2 cans"}]}}) {
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
        }
      GRAPHQL

      post '/graphql', params: { query: mutation_string }
      results = JSON.parse(response.body, symbolize_names: true)
      # binding.pry
      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data]).to have_key(:updateRecipe)
      expect(results[:data][:updateRecipe]).to be_a(Hash)
      expect(results[:data][:updateRecipe]).to have_key(:recipe)
    end
  end

  describe 'sad-paths' do
    it 'cannot update a user with non-existing id' do
      query_string = <<-GRAPHQL
        mutation {
          updateRecipe(input: {params: {id: 15, userId: 1, title: "Lasagna", description: "Layers of goodness!"}}) {
            recipe {
              id
              userId
              image
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

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:errors)
      expect(results[:errors]).to be_an(Array)
      expect(results[:errors][0][:message]).to eq("No record of Recipe with ID 15")
    end
  end
end
