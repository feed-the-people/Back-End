module Types
  module Input
    module Ingredients
      class UpdateInputType < Types::BaseInputObject
        argument :id, ID, required: true
        argument :name, String, required: false
        argument :amount, String, required: false
      end
    end
  end
end
