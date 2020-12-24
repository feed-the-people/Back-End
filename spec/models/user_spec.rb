require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    xit { should have_many :recipes }
    xit { should have_many :user_recipes }
  end

  describe 'validations' do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_presence_of :password }
  end
end
