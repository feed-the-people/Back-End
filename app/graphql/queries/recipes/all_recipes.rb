module Queries
  module Recipes
    class AllRecipes < Queries::BaseQuery

      type [Types::RecipeType], null: false

      def resolve
        Recipe.all.order(created_at: :desc)
      end
    end
  end
end
