module Types
  class MutationType < Types::BaseObject
    field :create_user_recipe, mutation: Mutations::UserRecipes::CreateUserRecipe
    field :update_rating, mutation: Mutations::UserRecipes::UpdateRating
    field :user_sign_in, mutation: Mutations::Users::UserSignIn
  end
end
