module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login

    field :create_questionnaire, mutation: Mutations::CreateQuestionnaire
    field :update_questionnaire, mutation: Mutations::UpdateQuestionnaire
    field :remove_questionnaire, mutation: Mutations::RemoveQuestionnaire

    field :add_question, mutation: Mutations::AddQuestion
    field :update_question, mutation: Mutations::UpdateQuestion
    field :remove_question, mutation: Mutations::RemoveQuestion

    field :add_options, mutation: Mutations::AddOptions

    field :vote, mutation: Mutations::Vote
  end
end
