module Types
  class RecipeType < Types::BaseObject
    field :id, ID, null: false
    field :image, String, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :charity_id, String, null: false
    field :charity_name, String, null: false
    field :avg_rating, Float, null: true
    field :user_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ingredients, [Types::IngredientType], null: true
    field :instructions, [Types::InstructionType], null: true
  end
end
