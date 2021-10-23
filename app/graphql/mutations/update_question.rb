module Mutations
  class UpdateQuestion < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: true
    argument :question_type, String, required: true
    argument :options_attributes, [Types::OptionAttributes], required: false

    field :errors, [String], null: true
    field :question, Types::QuestionType, null: false

    def resolve(id:, title:, question_type:, options_attributes:)
      current_user = context[:current_user]
      return unless current_user
      question = Question.find(id)

      _options_attributes = options_attributes.as_json(only: %i[id title _destroy])
      question.update(title: title, question_type: question_type, options_attributes: _options_attributes)

      if question.save!
        {
          question: question,
          errors: []
        }
      else
        {
          errors: ['question update failed']
        }
      end
    end
  end
end