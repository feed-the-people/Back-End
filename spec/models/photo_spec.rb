require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'relationships' do
    it { should have_many :user_photos }
    it { should have_many :user_photos }
  end

  describe 'validations' do
    it { should validate_presence_of :url }
  end
end
