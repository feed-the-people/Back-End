module Mutations
  module Recipes
    class CreateRecipe < Mutations::BaseMutation
      argument :params, Types::Input::Recipes::RecipeInputType, required: true

      field :recipe, Types::RecipeType, null: false

      def resolve(params:)
        recipe = create_recipe(params)
        recipe.ingredients.create(params.to_h[:ingredients])
        { recipe: recipe }
      end

      def create_recipe(params)
        recipe = Recipe.create(
          user_id: params.user_id.to_i,
          title: params.title,
          description: params.description,
          instructions: params.instructions,
          charity_id: params.charity_id.to_i,
          charity_name: params.charity_name)

        return recipe if recipe.save rescue false
      end
    end
  end
end
