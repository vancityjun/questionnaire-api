module Mutations
  class RemoveQuestionnaire < Mutations::BaseMutation
    argument :id, ID, required: true

    field :errors, [String], null: false
    field :message, String, null: false

    def resolve(id:)
      user = context[:current_user]
      return unless context[:current_user]

      questionnaire = user.questionnaires.find(id)

      if questionnaire.destroy!
        {
          message: 'Successfully deleted',
          errors: []
        }
      else
        { errors: ['there was an error while deleting questionnaire'] }
      end
    end
  end
end