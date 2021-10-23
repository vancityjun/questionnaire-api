module Types
  class OptionType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :voters, [Types::UserType], null: false
  end
end
