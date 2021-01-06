module Mutations
  module Users
    class RegisterUser < BaseMutation
      class AuthProviderSignupData < Types::BaseInputObject
        argument :credentials, Types::AuthProviderCredentialsInput, required: true
      end

      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :street, String, required: true
      argument :city, String, required: true
      argument :state, String, required: true
      argument :zip, String, required: true
      argument :image, String, required: true

      argument :auth_provider, AuthProviderSignupData, required: true

      type Types::UserType

      def resolve(auth_provider: nil, first_name: nil, last_name: nil, street: nil, city: nil, state: nil, zip: nil, image: nil)
        User.create!(
          username: auth_provider&.[](:credentials)&.[](:username),
          password: auth_provider&.[](:credentials)&.[](:password),
          first_name: first_name,
          last_name: last_name,
          street: street,
          city: city,
          state: state,
          zip: zip,
          image: image
                  )
      end
    end
  end
end