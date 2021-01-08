require 'rails_helper'

describe NpoFacade do
  it "returns an array of Non-Profits" do
    collection = NpoFacade.search_npo("Food bank of the Rockies")
    expect(collection.count).to eq(3)
    
    collection.each do |npo|
      expect(npo.ein).to be_an(Integer)
      expect(npo.name).to be_a(String)
      expect(npo.city).to be_a(String)
      expect(npo.state).to be_a(String)
    end
  end
end