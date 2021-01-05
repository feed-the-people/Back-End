module Types
  class UserRecipeType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :recipe_id, ID, null: false
    field :amount_donated, Float, null: false
    field :recipe_rating, Float, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
  