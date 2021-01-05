module Types
  class QueryType < Types::BaseObject
    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end

    def get_user(id:)
      User.find(id)
    end

    field :bought_recipes_by_user, [Types::UserRecipeType], null: false, description: 'Returns user recipes where the user id is as specified' do
      argument :user_id, ID, required: true
    end

    def bought_recipes_by_user(user_id:)
      UserRecipe.where(user_id: user_id)
    end
  end
end
