module Mutations
  class AddQuestion < Mutations::BaseMutation
    argument :questionnaire_id, ID, required: true
    argument :title, String, required: true
    argument :question_type, String, required: true

    field :errors, [String], null: true
    field :questionnaire, Types::QuestionnaireType, null: false

    def resolve(title:, questionnaire_id:, question_type:)
      return unless context[:current_user]
      questionnaire = Questionnaire.find(questionnaire_id)
      questionnaire.questions.build(title: title, question_type: question_type)

      if questionnaire.save!
        {
          questionnaire: questionnaire,
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