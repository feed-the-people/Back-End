require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user, :with_recipes)
      @user_1.user_recipes.create(recipe: @user_2.recipes.first, amount_donated: 2.50)
    end

    def query(id:)
      <<~GQL
        query {
          getUser(
            id: #{id}
          ) {
            id
            image
            username
            firstName
            lastName
            email
            state
            city
            street
            zip
            createdAt
            updatedAt
            recipes {
                id
            }
            userRecipes{
              id
              recipe{
                id
                title
              }
            }
          }
        }
      GQL
    end

    it 'can get a single user without any recipes' do
      post '/graphql', params: { query: query(id: @user_1.id) }

      json = JSON.parse(response.body)

      expect(json['data']['getUser']['id']).to eq(@user_1.id.to_s)
      expect(json['data']['getUser']['image']).to eq(@user_1.image)
      expect(json['data']['getUser']['username']).to eq(@user_1.username)
      expect(json['data']['getUser']['firstName']).to eq(@user_1.first_name)
      expect(json['data']['getUser']['lastName']).to eq(@user_1.last_name)
      expect(json['data']['getUser']['email']).to eq(@user_1.email)
      expect(json['data']['getUser']['street']).to eq(@user_1.street)
      expect(json['data']['getUser']['city']).to eq(@user_1.city)
      expect(json['data']['getUser']['state']).to eq(@user_1.state)
      expect(json['data']['getUser']['zip']).to eq(@user_1.zip)
      expect(json['data']['getUser']['recipes']).to eq([])
      expect(json['data']['getUser']['userRecipes']).to be_an(Array)
      expect(json['data']['getUser']['userRecipes'][0]['recipe']['title']).to eq(@user_2.recipes.first.title)
    end

    it 'can get a single user with some recipes' do
      post '/graphql', params: { query: query(id: @user_2.id) }

      json = JSON.parse(response.body)

      expect(json['data']['getUser']['id']).to eq(@user_2.id.to_s)
      expect(json['data']['getUser']['image']).to eq(@user_2.image)
      expect(json['data']['getUser']['username']).to eq(@user_2.username)
      expect(json['data']['getUser']['firstName']).to eq(@user_2.first_name)
      expect(json['data']['getUser']['lastName']).to eq(@user_2.last_name)
      expect(json['data']['getUser']['email']).to eq(@user_2.email)
      expect(json['data']['getUser']['street']).to eq(@user_2.street)
      expect(json['data']['getUser']['city']).to eq(@user_2.city)
      expect(json['data']['getUser']['state']).to eq(@user_2.state)
      expect(json['data']['getUser']['zip']).to eq(@user_2.zip)
      expect(json['data']['getUser']['recipes'].size).to eq(3)
      expect(json['data']['getUser']['recipes']).to match_array(
        @user_2.recipes.map do |recipe|
          { 'id' => recipe.id.to_s }
        end
      )
    end
  end
end
