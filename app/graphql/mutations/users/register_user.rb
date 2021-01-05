module Mutations
  module Users
    class RegisterUser < BaseMutation
      class AuthProviderSignupData < Types::BaseInputObject
        argument :credentials, Types::AuthProviderCredentialsInput, required: false
      end

      argument :auth_provider, AuthProviderSignupData, required: true

      type Types::UserType

      def resolve(name: nil, auth_provider: nil)
        User.create!(
          username: auth_provider&.[](:credentials)&.[](:username),
          password: auth_provider&.[](:credentials)&.[](:password)
        )
      end
    end
  end
end