module Types
  module Input
    module Instructions
      class InstructionInputType < Types::BaseInputObject
        argument :recipe_id, ID, required: true
        argument :description, String, required: true
      end
    end
  end
end
