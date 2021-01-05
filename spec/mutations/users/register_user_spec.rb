require 'rails_helper'

module Mutations
  module Users
    RSpec.describe RegisterUser, type: :request do
      describe '.resolve' do
        it 'creates a user' do

          def perform(args = {})
            Mutations::Users::RegisterUser.new(object: nil, field: nil, context: {}).resolve(args)
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

          @user = perform({
            image: 'www.image.com',
                firstName: 'Test',
                lastName: 'User',
                state: 'CO',
                city: 'Denver',
                street: '1234 Road Street',
                zip: '1234'
            auth_provider: {
              credentials: {
                username: 'email@example.com',
                password: '[omitted]'
              }
            }
          }
          )
          binding.pry
          expect(@user.username).to eq('email@example.com')
          expect(User.count).to eq(1)

      post '/graphql', params: { query: query(id: @user.id) }

      json = JSON.parse(response.body)
      expect(json['data']['getUser']['id']).to eq(@user.id.to_s)
      expect(json['data']['getUser']['username']).to eq(@user.username)
        end
      end
    end
  end
end

