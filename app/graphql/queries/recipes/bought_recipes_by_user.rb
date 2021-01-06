module Queries
  module Recipes
    class BoughtRecipesByUser < Queries::BaseQuery
      argument :user_id, ID, required: true
      type [Types::UserRecipeType], null: false

      def resolve(user_id:)
        if User.exists?(user_id)
          UserRecipe.where(user_id: user_id)
        else
          GraphQL::ExecutionError.new("No record of User with ID #{user_id}")
        end
      end
    end
  end
end
