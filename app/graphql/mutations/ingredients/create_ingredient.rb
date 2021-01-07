module Mutations
  module Ingredients
    class CreateIngredient < Mutations::BaseMutation
      argument :params, Types::Input::Ingredients::IngredientInputType, required: true

      field :ingredient, Types::IngredientType, null: false

      def resolve(params:)
        recipe = recipe_exists?(params[:recipe_id])
        if recipe
          ingredient = recipe.ingredients.create(params.to_h)
          { ingredient: ingredient }
        else
          GraphQL::ExecutionError.new("No record of Recipe with ID #{params[:recipe_id]}")
        end
      end

      def recipe_exists?(id)
        Recipe.find(id) rescue false
      end
    end
  end
end
