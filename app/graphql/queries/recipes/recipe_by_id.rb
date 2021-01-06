module Queries
  module Recipes
    class RecipeById < Queries::BaseQuery
      type Types::RecipeType, null: false
      argument :id, ID, required: true

      def resolve(id:)        
        Recipe.find(id)
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new('Recipe does not exist.')
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
