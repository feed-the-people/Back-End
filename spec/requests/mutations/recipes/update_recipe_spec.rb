require 'rails_helper'

RSpec.describe 'Update Recipe' do
  before :each do
    @user = create(:user)
    @recipe = create(:recipe, user_id: @user.id, image: "https://loremflickr.com/50/60/food", title: "Chicken Parmesan", description: "A classic favorite!", instructions: "1. chicken 2.???? 3. profit", charity_id: "533423", charity_name: "Boys & Girls Club")
  end

  describe 'happy-paths' do
    it 'updates recipe attributes' do
      mutation_string = <<-GRAPHQL
      mutation {
        updateRecipe(input: {params: {
          id: #{@recipe.id},
          title: "Food Experiment",
          description: "A combination of random test ingredients to make something that's maybe edible?",
          instructions: "1. Something 2. Something Else 3. Something Delicious!"
        }}) {
          recipe {
            id
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

      post '/graphql', params: { query: mutation_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data]).to have_key(:updateRecipe)
      expect(results[:data][:updateRecipe]).to be_a(Hash)
      expect(results[:data][:updateRecipe]).to have_key(:recipe)

      expect(results[:data][:updateRecipe][:recipe]).to be_a(Hash)
      expect(results[:data][:updateRecipe][:recipe]).to have_key(:id)
      expect(results[:data][:updateRecipe][:recipe][:id]).to be_a(String)

      expect(results[:data][:updateRecipe][:recipe]).to have_key(:image)
      expect(results[:data][:updateRecipe][:recipe][:image]).to be_a(String)

      expect(results[:data][:updateRecipe][:recipe]).to have_key(:title)
      expect(results[:data][:updateRecipe][:recipe][:title]).to be_a(String)
      expect(results[:data][:updateRecipe][:recipe][:title]).to_not eq("Chicken Parmesan")

      expect(results[:data][:updateRecipe][:recipe]).to have_key(:description)
      expect(results[:data][:updateRecipe][:recipe][:description]).to be_a(String)
      expect(results[:data][:updateRecipe][:recipe][:description]).to_not eq("A classic favorite!")

      expect(results[:data][:updateRecipe][:recipe]).to have_key(:instructions)
      expect(results[:data][:updateRecipe][:recipe][:instructions]).to be_a(String)
      expect(results[:data][:updateRecipe][:recipe][:instructions]).to_not eq("1. chicken 2.???? 3. profit")

      expect(results[:data][:updateRecipe][:recipe]).to have_key(:ingredients)
      expect(results[:data][:updateRecipe][:recipe][:ingredients]).to be_an(Array)
    end
  end

  describe 'sad-paths' do
    it 'cannot update a user with non-existing id' do
      mutation_string = <<-GRAPHQL
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

      post '/graphql', params: { query: mutation_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:errors)
      expect(results[:errors]).to be_an(Array)
      expect(results[:errors][0][:message]).to eq("No record of Recipe with ID 15")
    end
  end
end
