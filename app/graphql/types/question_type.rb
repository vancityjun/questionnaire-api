module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :question_type, String, null: false
    field :options, [Types::OptionType], null: true
  end
end
