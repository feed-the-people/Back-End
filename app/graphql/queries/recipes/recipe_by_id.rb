module Queries
  module Recipes
    class RecipeById < Queries::BaseQuery
      type Types::RecipeType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        Recipe.find(id.to_i)
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new('Recipe does not exist.')
      end
    end
  end
end
