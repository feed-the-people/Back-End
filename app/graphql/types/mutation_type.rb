module Types
  class MutationType < Types::BaseObject
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :update_rating, mutation: Mutations::UserRecipes::UpdateRating
  end
end
