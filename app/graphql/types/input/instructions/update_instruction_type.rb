module Types
  module Input
    module Instructions
      class UpdateInputType < Types::BaseInputObject
        argument :id, ID, required: true
        argument :description, String, required: false
      end
    end
  end
end
