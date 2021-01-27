class Instruction < ApplicationRecord
  belongs_to :recipe
  validates :description, presence: true
end
