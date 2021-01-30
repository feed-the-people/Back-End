require 'rails_helper'

RSpec.describe UserPhoto, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :photo }
  end
end
