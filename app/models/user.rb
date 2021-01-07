class User < ApplicationRecord
  has_secure_password

  has_many :user_recipes
  has_many :recipes

  validates :password_digest, presence: true
  validates :username, uniqueness: true, presence: true
  # validates_format_of :zip,
  #                     :with => %r{\d{5}(-\d{4})?},
  #                     :message => "should be formatted as 12345 or 12345-1234"
end
