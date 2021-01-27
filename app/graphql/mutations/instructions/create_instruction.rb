module Mutations
  module Instructions
    class CreateInstruction < Mutations::BaseMutation
      argument :params, Types::Input::Instructions::InstructionInputType, required: true

      field :instruction, Types::InstructionType, null: false

      def resolve(params:)
        recipe = recipe_exists?(params[:recipe_id])
        if recipe
          instruction = recipe.instructions.create(params.to_h)
          { instruction: instruction }
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
