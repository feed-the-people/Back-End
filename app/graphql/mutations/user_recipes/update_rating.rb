module Mutations
  module UserRecipes
    class UpdateRating < Mutations::BaseMutation
      argument :params, Types::Input::UserRecipes::UpdateType, required: true
  
      field :user_recipe, Types::UserRecipeType, null: false
  
      def resolve(params:)
        rating_params = Hash params
        if valid_rating?(rating_params[:recipe_rating])
            begin
                user_recipe = UserRecipe.find(rating_params[:id])
                user_recipe.update!(recipe_rating: rating_params[:recipe_rating])
        
                { user_recipe: user_recipe }
              rescue ActiveRecord::RecordInvalid => e
                GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
                  " #{e.record.errors.full_messages.join(', ')}")
              end
        else
            GraphQL::ExecutionError.new("Number must be greater than 0 and less than 5.")
        end
      end

      def valid_rating?(number)
        number > 0 && number <= 5
      end
    end
  end
end