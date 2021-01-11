module Mutations
  module Recipes
    class UpdateRecipe < Mutations::BaseMutation
      argument :params, Types::Input::Recipes::UpdateRecipeType, required: true

      field :recipe, Types::RecipeType, null: false

      def resolve(params:)
        recipe_params = Hash params
        if valid_recipe_id?(recipe_params[:id])
          recipe = Recipe.find(recipe_params[:id])
          recipe.update(recipe_params)
          # recipe.ingredients.update(recipe_params.to_h[:ingredients])

          { recipe: recipe }
        else
          GraphQL::ExecutionError.new("No record of Recipe with ID #{recipe_params[:id]}")
        end
      end

      def valid_recipe_id?(id)
        Recipe.exists?(id) rescue false
      end
    end
  end
end
