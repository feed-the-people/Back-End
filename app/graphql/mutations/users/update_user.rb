module Mutations
  module Users
    class UpdateUser < Mutations::BaseMutation
      argument :params, Types::Input::Users::UpdateUserType, required: true

      field :user, Types::UserType, null: false

      def resolve(params:)
        user_params = Hash params
        if valid_id?(user_params[:id])
          user = User.find(user_params[:id])
          user.update!(user_params)

          { user: user }
        end
      end

      def valid_id?(id)
        User.find(id) rescue false
      end

      # def valid_user_params?(user_params)
      #   if !valid_username?(user_params[:username]) || !valid_first_name?(user_params[:firstName]) ||
      #   !valid_last_name?(user_params[:lastName]) || !valid_street?(user_params[:street]) || !valid_city?(user_params[:city]) || !valid_state?(user_params[:state]) || !valid_zip?(user_params[:zip])
      #     false
      #   else
      #     true
      #   end
      # end
      #
      # def valid_username?(username)
      #
      # end
    end
  end
end
