module Mutations
  class RemoveQuestion < Mutations::BaseMutation
    argument :questionnaire_id, ID, required: true
    argument :id, ID, required: true

    field :errors, [String], null: false
    field :message, String, null: false

    def resolve(id:, questionnaire_id:)
      user = context[:current_user]
      return unless context[:current_user]

      question = user.questionnaires.find(questionnaire_id).questions.find(id)

      if question.destroy!
        {
          message: 'Successfully deleted',
          errors: []
        }
      else
        { errors: ['there was an error while deleting question'] }
      end
    end
  end
end