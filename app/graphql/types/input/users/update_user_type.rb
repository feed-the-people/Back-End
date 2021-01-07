module Types
  module Input
    module Users
      class UpdateUserType < Types::BaseInputObject
        argument :id, Integer, required: true
        argument :image, String, required: false
        argument :username, String, required: false
        argument :first_name, String, required: false
        argument :last_name, String, required: false
        argument :street, String, required: false
        argument :city, String, required: false
        argument :state, String, required: false
        argument :zip, String, required: false
      end
    end
  end
end
