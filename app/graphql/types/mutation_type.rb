module Types
  class MutationType < Types::BaseObject
    field :create_user_recipe, mutation: Mutations::UserRecipes::CreateUserRecipe
  end
end
