module Mutations
  module Ingredients
    class UpdateIngredient < Mutations::BaseMutation
      argument :params, Types::Input::Ingredients::UpdateInputType, required: true

      field :ingredient, Types::IngredientType, null: false

      def resolve(params:)
        ingredient_params = Hash params
        if Ingredient.exists?(ingredient_params[:id])
          ingredient = Ingredient.find(ingredient_params[:id])
          ingredient.update!(ingredient_params)
          { ingredient: ingredient }
        else
          GraphQL::ExecutionError.new("No record of Ingredient with ID #{ingredient_params[:id]}")
        end
      end
    end
  end
end
