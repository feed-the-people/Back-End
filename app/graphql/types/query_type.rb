module Types
  class QueryType < Types::BaseObject
    field :all_recipes, resolver: Queries::Recipes::AllRecipes
    field :bought_recipes_by_user, resolver: Queries::Recipes::BoughtRecipesByUser
    field :get_user, resolver: Queries::Users::GetUser
  end
end
