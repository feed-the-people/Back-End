module Types
  class NpoType < Types::BaseObject
    field :ein, ID, null: false
    field :name, String, null: false
    field :city, String, null: false
    field :state, String, null: false
  end
end