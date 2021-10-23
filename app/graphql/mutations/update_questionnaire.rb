module Mutations
  class UpdateQuestionnaire < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false

    field :errors, [String], null: true
    field :questionnaire, Types::QuestionnaireType, null: false

    def resolve(id:, title:)
      current_user = context[:current_user]
      return unless current_user
      questionnaire = current_user.questionnaires.find(id)
      questionnaire.update(title: title)


      if questionnaire.save!
        {
          questionnaire: questionnaire,
          errors: []
        }
      else
        {
          errors: ['questionnaire create failed']
        }
      end

    end
  end
end