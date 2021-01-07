module Mutations
  module Users
    class UpdateUser < Mutations::BaseMutation
      argument :params, Types::Input::Users::UpdateUserType, required: true

      field :user, Types::UserType, null: false

      def resolve(params:)
        user_params = Hash params
        if valid_user_id?(user_params[:id])
          user = User.find(user_params[:id])
          user.update!(user_params)

          { user: user }
        elsif !valid_user_id?(user_params[:id])
          GraphQL::ExecutionError.new("No record of User with ID #{user_params[:id]}")
        end
      end

      def valid_user_id?(id)
        User.find(id) rescue false
      end

      # def zip_error_message
      #   GraphQL::ExecutionError.new("Zip should be formatted as 12345 or 12345-1234")
      # end
    end
  end
end
