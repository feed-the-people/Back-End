module Mutations
  module Users
    class UserSignIn < Mutations::BaseMutation
      argument :credentials, Types::Input::AuthProviderCredentialsInput, required: true

      field :token, String, null: true
      field :user, Types::UserType, null: true


      def resolve(credentials: nil)
        return unless credentials

        user = User.find_by(username: credentials[:username])

        return GraphQL::ExecutionError.new("No record of user with username #{credentials[:username]}") unless user
        return GraphQL::ExecutionError.new("Cannot log in with bad credentials") unless user.authenticate(credentials[:password])

        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user_id:#{ user.id }")

        { user: user, token: token }
      end
    end
  end
end
