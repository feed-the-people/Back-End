module Mutations
  module Instructions
    class UpdateInstruction < Mutations::BaseMutation
      argument :params, Types::Input::Instructions::UpdateInputType, required: true

      field :instruction, Types::InstructionType, null: false

      def resolve(params:)
        instruction_params = Hash params
        if Instruction.exists?(instruction_params[:id])
          instruction = Instruction.find(instruction_params[:id])
          instruction.update!(instruction_params)
          { instruction: instruction }
        else
          GraphQL::ExecutionError.new("No record of Instruction with ID #{instruction_params[:id]}")
        end
      end
    end
  end
end
