module Types
  class IngredientType < Types::BaseObject
    field :id, ID, null: false
    field :recipe_id, ID, null: false
    field :name, String, null: false
    field :amount, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
