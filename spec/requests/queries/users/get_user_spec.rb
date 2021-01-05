require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user, :with_recipes)
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
            state
            city
            street
            zip
            createdAt
            updatedAt
            recipes {
                id
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
      expect(json['data']['getUser']['street']).to eq(@user_1.street)
      expect(json['data']['getUser']['city']).to eq(@user_1.city)
      expect(json['data']['getUser']['state']).to eq(@user_1.state)
      expect(json['data']['getUser']['zip']).to eq(@user_1.zip)
      expect(json['data']['getUser']['recipes']).to eq([])
    end

    it 'can get a single user with some recipes' do
      post '/graphql', params: { query: query(id: @user_2.id) }

      json = JSON.parse(response.body)

      expect(json['data']['getUser']['id']).to eq(@user_2.id.to_s)
      expect(json['data']['getUser']['image']).to eq(@user_2.image)
      expect(json['data']['getUser']['username']).to eq(@user_2.username)
      expect(json['data']['getUser']['firstName']).to eq(@user_2.first_name)
      expect(json['data']['getUser']['lastName']).to eq(@user_2.last_name)
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