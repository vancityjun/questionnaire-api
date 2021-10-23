module Mutations
  class CreateQuestionnaire < Mutations::BaseMutation
    argument :title, String, required: true

    field :errors, [String], null: true
    field :questionnaire, Types::QuestionnaireType, null: false

    def resolve(title:)
      current_user = context[:current_user]
      return unless current_user
      questionnaire = Questionnaire.new(title: title)
      questionnaire.user = current_user
      
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