module Queries
  module Users
    class GetUser < Queries::BaseQuery
      argument :id, ID, required: true
      type Types::UserType, null: false

      def resolve(id:)
        if User.exists?(id)
          User.find(id)
        else
          GraphQL::ExecutionError.new("No record of User with ID #{id}")
        end
      end
    end
  end
end