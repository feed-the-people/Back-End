require 'rails_helper'

RSpec.describe "userSignIn" do
  before :each do 
    @user = create(:user, password: '1234')
  end
  def query(username:, password:)
    <<~GQL
      mutation {
        userSignIn(input: { credentials: {
          username: "#{username}"
          password: "#{password}"
        }}) {
          token
          user {
            id
            image
            username
            firstName
            lastName
            street
            city
            state
            zip
            createdAt
            updatedAt
          }
        }
      }
    GQL
  end

  describe 'happy paths' do
    it 'A user can sign in' do
      post '/graphql', params: { query: query(username: @user.username, password: "1234") }

      json = JSON.parse(response.body)

      expect(json['data']['userSignIn']['token']).to_not eq(nil)
      expect(json['data']['userSignIn']['token']).to be_a(String)
      expect(json['data']['userSignIn']['user']['id']).to eq(@user.id.to_s)
      expect(json['data']['userSignIn']['user']['image']).to eq(@user.image)
      expect(json['data']['userSignIn']['user']['username']).to eq(@user.username)
      expect(json['data']['userSignIn']['user']['firstName']).to eq(@user.first_name)
      expect(json['data']['userSignIn']['user']['lastName']).to eq(@user.last_name)
      expect(json['data']['userSignIn']['user']['street']).to eq(@user.street)
      expect(json['data']['userSignIn']['user']['city']).to eq(@user.city)
      expect(json['data']['userSignIn']['user']['state']).to eq(@user.state)
      expect(json['data']['userSignIn']['user']['zip']).to eq(@user.zip)
    end
  end

  describe 'sad paths' do
    it 'a user cannot log in with a wrong password' do
      post '/graphql', params: { query: query(username: @user.username, password: "wrong") }

      json = JSON.parse(response.body)

      expect(json['errors'][0]['message']).to eq("Cannot log in with bad credentials")
    end

    it 'a user cannot log in if the user does not exist' do
      post '/graphql', params: { query: query(username: "Mister Miyagi", password: "1234") }

      json = JSON.parse(response.body)

      expect(json['errors'][0]['message']).to eq("No record of user with username Mister Miyagi")
    end
  end
end