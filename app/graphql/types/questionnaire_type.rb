module Types
  class QuestionnaireType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :questions, [Types::QuestionType], null: false
  end
end
