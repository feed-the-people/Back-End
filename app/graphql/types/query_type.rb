module Types
  class QueryType < Types::BaseObject
    field :all_recipes, resolver: Queries::Recipes::AllRecipes
    field :bought_recipes_by_user, resolver: Queries::Recipes::BoughtRecipesByUser
    
    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end

    def get_user(id:)
      User.find(id)
    end

  end
end
