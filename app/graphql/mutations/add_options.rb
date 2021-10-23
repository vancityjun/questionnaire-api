module Mutations
  class AddOptions < Mutations::BaseMutation
    argument :question_id, ID, required: true
    argument :questions_attributes, [Types::OptionAttributes], required: true

    field :errors, [String], null: true
    field :question, Types::QuestionType, null: false

    def resolve(question_id:, questions_attributes:)
      return unless context[:current_user]
      question = question.find(question_id)

      questions_attributes.each do |attrs|
        question.options.build(title: attrs[:title])
      end

      if question.save!
        {
          question: question,
          errors: []
        }
      else
        {
          errors: ['question create failed']
        }
      end
    end
  end
end