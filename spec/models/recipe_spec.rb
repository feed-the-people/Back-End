require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'relationships' do
    it { should have_many :user_recipes }
    it { should have_many :ingredients }
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :instructions }
    xit { should validate_presence_of :charity_id }
  end
end
