require 'rails_helper'

RSpec.describe 'User Update' do
  before :each do
    @user = create(:user, image: "https://robohash.org/my-own-slug.png?size=50x50&set=set1", username: "123user", first_name: "Martha", last_name: "Stewart", email: "test@email.com", street: "123 Westside Ave", city: "Los Angeles", state: "CA", zip: "90210" )
    @user_id = @user.id
  end

  describe 'happy-paths' do
    it 'updates user attributes' do
      query_string = <<-GRAPHQL
        mutation {
          updateUser(input: { params: { id: #{@user_id}, image: "https://robohash.org/new-slug-edit-update.png?size=50x50&set=set1", username: "food_love123", firstName: "Chef", lastName: "Ratatouille", email: "bonappetit@email.com", street: "234 Paris Ave", city: "New York", state: "NY", zip: "10025" } }) {
            user {
              id
              image
              username
              firstName
              lastName
              email
              street
              city
              state
              zip
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:data)
      expect(results[:data]).to be_a(Hash)
      expect(results[:data]).to have_key(:updateUser)
      expect(results[:data][:updateUser]).to be_a(Hash)
      expect(results[:data][:updateUser]).to have_key(:user)

      expect(results[:data][:updateUser][:user]).to be_a(Hash)
      expect(results[:data][:updateUser][:user]).to have_key(:id)
      expect(results[:data][:updateUser][:user][:id]).to be_a(String)

      expect(results[:data][:updateUser][:user]).to have_key(:image)
      expect(results[:data][:updateUser][:user][:image]).to be_a(String)
      expect(results[:data][:updateUser][:user][:image]).to_not eq("https://robohash.org/my-own-slug.png?size=50x50&set=set1")

      expect(results[:data][:updateUser][:user]).to have_key(:username)
      expect(results[:data][:updateUser][:user][:username]).to be_a(String)
      expect(results[:data][:updateUser][:user][:username]).to_not eq("123user")

      expect(results[:data][:updateUser][:user]).to have_key(:firstName)
      expect(results[:data][:updateUser][:user][:firstName]).to be_a(String)
      expect(results[:data][:updateUser][:user][:firstName]).to_not eq("Martha")

      expect(results[:data][:updateUser][:user]).to have_key(:lastName)
      expect(results[:data][:updateUser][:user][:lastName]).to be_a(String)
      expect(results[:data][:updateUser][:user][:lastName]).to_not eq("Stewart")

      expect(results[:data][:updateUser][:user]).to have_key(:email)
      expect(results[:data][:updateUser][:user][:email]).to be_a(String)
      expect(results[:data][:updateUser][:user][:email]).to_not eq("test@email.com")

      expect(results[:data][:updateUser][:user]).to have_key(:street)
      expect(results[:data][:updateUser][:user][:street]).to be_a(String)
      expect(results[:data][:updateUser][:user][:street]).to_not eq("123 Westside Ave")

      expect(results[:data][:updateUser][:user]).to have_key(:city)
      expect(results[:data][:updateUser][:user][:city]).to be_a(String)
      expect(results[:data][:updateUser][:user][:city]).to_not eq("Los Angeles")

      expect(results[:data][:updateUser][:user]).to have_key(:state)
      expect(results[:data][:updateUser][:user][:state]).to be_a(String)
      expect(results[:data][:updateUser][:user][:state]).to_not eq("CA")

      expect(results[:data][:updateUser][:user]).to have_key(:zip)
      expect(results[:data][:updateUser][:user][:zip]).to be_a(String)
      expect(results[:data][:updateUser][:user][:zip]).to_not eq("90210")
    end
  end

  describe 'sad-paths' do
    it 'cannot update a user with non-existing id' do
      query_string = <<-GRAPHQL
        mutation {
          updateUser(input: { params: { id: 15, image: "https://robohash.org/new-slug-edit-update.png?size=50x50&set=set1", username: "food_love123", zip: "90272" } }) {
            user {
              id
              image
              username
              firstName
              lastName
              email
              street
              city
              state
              zip
            }
          }
        }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:errors)
      expect(results[:errors]).to be_an(Array)
      expect(results[:errors][0][:message]).to eq("No record of User with ID 15")
    end
  end
end
