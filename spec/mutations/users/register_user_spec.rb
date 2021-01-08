require 'rails_helper'

module Mutations
  module Users
    RSpec.describe RegisterUser, type: :request do
      describe '.resolve' do
        it 'creates a new user' do
          @input = {
                    image: "www.image.com",
                    firstName: "Test",
                    lastName: "User",
                    state: "CO",
                    city: "Denver",
                    street: "1234 Road Street",
                    zip: "1234",
                    email: "test_user@email.com",
                    authProvider: {
                      credentials: {
                        username: "AnothaOne",
                        password: "[omitted]"
                      }
                    }
                  }

          def mutation
              <<~GQL
              mutation {
                registerUser( input: {
                  image: "www.image.com",
                  firstName: "Test",
                  lastName: "User",
                  state: "CO",
                  city: "Denver",
                  street: "1234 Road Street",
                  zip: "1234",
                  email: "test_user@email.com",
                  authProvider: {
                    credentials: {
                      username: "AnothaOne",
                      password: "[omitted]"
                    }
                  }
                }
              )
              { user{
                id
                username
                firstName
                lastName
                state
                city
                street
                zip
                email
                image
                }
              }
            }
            GQL
          end

          post '/graphql', params: { query: mutation }

          user = JSON.parse(response.body)['data']['registerUser']['user']
          expect(user['username']).to eq(@input[:authProvider][:credentials][:username])
          expect(user['firstName']).to eq(@input[:firstName])
          expect(user['lastName']).to eq(@input[:lastName])
          expect(user['state']).to eq(@input[:state])
          expect(user['city']).to eq(@input[:city])
          expect(user['zip']).to eq(@input[:zip])
          expect(user['email']).to eq(@input[:email])
          expect(user['image']).to eq(@input[:image])
        end
      end
    end
  end
end
