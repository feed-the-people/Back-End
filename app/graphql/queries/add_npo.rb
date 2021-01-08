module Queries
    class AddNpo < Queries::BaseQuery
      argument :search_term, required: true
      type [Types::NpoType], null: false

      def resolve(search_term:)
        collection = NpoFacade.search_npo(search_term)
      end
    end
end