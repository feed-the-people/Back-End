require 'rails_helper'

RSpec.describe 'updateIngredient' do
  before :each do
    @user = create(:user, :with_recipes)
    @recipe = @user.recipes.first
    @ingredient = create(:ingredient, recipe: @recipe)
  end

  def query
    <<-GQL
      mutation {
        updateIngredient( input: { params: { id: #{@ingredient.id.to_s} name: "changed ingredient" amount: "100 Cups" }}) {
          ingredient {
            id
            name
            amount
          }
        }
      }
    GQL
  end

  def query_two
    <<-GQL
      mutation {
        updateIngredient( input: { params: { id: #{@ingredient.id.to_s} amount: "100 Cups" }}) {
          ingredient {
            id
            name
            amount
          }
        }
      }
    GQL
  end

  def sad_query
    <<-GQL
      mutation {
        updateIngredient( input: { params: { id: "2345234" name: "changed ingredient" amount: "100 Cups" }}) {
          ingredient {
            id
            name
            amount
          }
        }
      }
    GQL
  end

  describe 'happy-path' do
    it 'can update an ingredient by id' do
      outdated_ingredient = @ingredient

      post '/graphql', params: { query: query }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:updateIngredient][:ingredient][:id]).to eq(@ingredient.id.to_s)

      expect(json[:data][:updateIngredient][:ingredient][:name]).to eq("changed ingredient")
      expect(json[:data][:updateIngredient][:ingredient][:name]).to_not eq(outdated_ingredient.name)

      expect(json[:data][:updateIngredient][:ingredient][:amount]).to eq("100 Cups")
      expect(json[:data][:updateIngredient][:ingredient][:amount]).to_not eq(outdated_ingredient.amount)
    end

    it 'can update an ingredient with only one param' do
      outdated_ingredient = @ingredient

      post '/graphql', params: { query: query_two }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:updateIngredient][:ingredient][:id]).to eq(@ingredient.id.to_s)

      expect(json[:data][:updateIngredient][:ingredient][:name]).to eq(outdated_ingredient.name)

      expect(json[:data][:updateIngredient][:ingredient][:amount]).to eq("100 Cups")
      expect(json[:data][:updateIngredient][:ingredient][:amount]).to_not eq(outdated_ingredient.amount)
    end
  end

  describe 'sad-path' do
    it 'cannot update an ingredient that doesnt exist' do
      post '/graphql', params: { query: sad_query }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors][0][:message]).to eq("No record of Ingredient with ID 2345234")
    end
  end
end
