module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::Users::RegisterUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :create_user_recipe, mutation: Mutations::UserRecipes::CreateUserRecipe
    field :update_rating, mutation: Mutations::UserRecipes::UpdateRating
    field :create_ingredient, mutation: Mutations::Ingredients::CreateIngredient
    field :update_ingredient, mutation: Mutations::Ingredients::UpdateIngredient
    field :create_instruction, mutation: Mutations::Instructions::CreateInstruction
    field :update_instruction, mutation: Mutations::Instructions::UpdateInstruction
    field :user_sign_in, mutation: Mutations::Users::UserSignIn
    field :create_recipe, mutation: Mutations::Recipes::CreateRecipe
    field :update_recipe, mutation: Mutations::Recipes::UpdateRecipe
  end
end
