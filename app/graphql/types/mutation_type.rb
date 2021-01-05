module Types
  class MutationType < Types::BaseObject
    field :create_user_recipe, mutation: Mutations::UserRecipes::CreateUserRecipe
    field :update_rating, mutation: Mutations::UserRecipes::UpdateRating
  end
end
