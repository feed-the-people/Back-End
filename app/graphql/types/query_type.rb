module Types
  class QueryType < Types::BaseObject
    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end

    def get_user(id:)
      User.find(id)
    end
  end
end
