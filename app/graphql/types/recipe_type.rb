module Types
  class RecipeType < Types::BaseObject
    field :id, ID, null: false
    field :image, String, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :instructions, String, null: false
    field :charity_id, String, null: false 
    # ^^ Left this as a string for now as I'm not 100% sure on how charities will be handled
    field :user_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
  