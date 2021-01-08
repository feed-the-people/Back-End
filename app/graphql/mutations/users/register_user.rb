module Mutations
  module Users
    class RegisterUser < BaseMutation
      class AuthProviderSignupData < Types::BaseInputObject
        argument :credentials, Types::Input::AuthProviderCredentialsInput, required: true
      end

      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :email, String, required: true
      argument :street, String, required: true
      argument :city, String, required: true
      argument :state, String, required: true
      argument :zip, String, required: true
      argument :image, String, required: true

      argument :auth_provider, AuthProviderSignupData, required: true

      # type Types::UserType
      field :user, Types::UserType, null: false

      def resolve(auth_provider: nil, first_name: nil, last_name: nil, email: nil, street: nil, city: nil, state: nil, zip: nil, image: nil)
        user = User.create!(
          username: auth_provider&.[](:credentials)&.[](:username),
          password: auth_provider&.[](:credentials)&.[](:password),
          first_name: first_name,
          last_name: last_name,
          email: email,
          street: street,
          city: city,
          state: state,
          zip: zip,
          image: image
        )

        {user: user}
      end
    end
  end
end
