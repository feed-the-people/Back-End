module Types
  class UserRecipeType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :recipe_id, Integer, null: false
    field :amounted_donated, Float, null: false
    field :recipe_rating, Float, null: false
  end
end
