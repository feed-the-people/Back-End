module Types
  class QueryType < Types::BaseObject
    field :all_recipes, resolver: Queries::Recipes::AllRecipes
    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end

    field :get_npo, resolver: Queries::GetNpo, null: false, description: 'Returns a collection of NPOs' do
      argument :search_term, String, required: true
    end
    field :get_user, resolver: Queries::Users::GetUser
    field :recipe_by_id, resolver: Queries::Recipes::RecipeById
  end
end
