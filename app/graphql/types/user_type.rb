module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :image, String, null: false
    field :username, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :street, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :recipes, [Types::RecipeType], null: false
  end
end
  