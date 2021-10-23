module Mutations
  class Vote < Mutations::BaseMutation
    argument :question_id, ID, required: true
    argument :option_ids, [ID], required: true

    field :errors, [String], null: true
    field :question, Types::QuestionType, null: false

    def resolve(question_id:, option_ids:)
      user = context[:current_user]
      return unless user

      question = Question.find(question_id)
      options = question.options.where(id: option_ids)

      result = ActiveRecord::Base.transaction do
        options.each do |option|
          option.voters << user
        end

        user.save!
      end

      if result
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
