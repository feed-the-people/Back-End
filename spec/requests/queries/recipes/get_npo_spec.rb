require 'rails_helper'

RSpec.describe 'Add NPO endpoint' do

  describe 'happy-path' do
    it 'gets all NPOs with the associated search team' do
      query_string = <<-GRAPHQL
        query {
          getNpo( searchTerm: "Food Bank of the Rockies") {
              ein
              name
              city
              state
        }
      }
      GRAPHQL

      post '/graphql', params: { query: query_string }
      results = JSON.parse(response.body, symbolize_names: true)[:data][:getNpo]
      expect(results).to be_an(Array)
      expect(results.count).to eq(3)

      results.each do |npo|
        expect(npo[:ein]).to be_an(String)
        expect(npo[:name]).to be_a(String)
        expect(npo[:city]).to be_a(String)
        expect(npo[:state]).to be_a(String)
      end
    end
  end
end