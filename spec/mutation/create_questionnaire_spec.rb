require 'rails_helper'

RSpec.describe Mutations::CreateQuestionnaire, type: :request do
  let!(:user) {create :user}

  it 'create questionnaire and return it' do
    query = <<-GQL
      mutation createQuestionnaire ($input: CreateQuestionnaireInput!) {
        createQuestionnaire (input: $input){
          questionnaire{
            id
            title
          }
        }
      }
    GQL

    variables = {
      title: 'Karaoke party',
    }
    result = ServerSchema.execute(
      query,
      variables: {input: variables},
      context: {current_user: user}
    ).to_h.deep_symbolize_keys[:data][:createQuestionnaire]
    questionnaire = Questionnaire.last

    expect(result[:questionnaire]).to match({
      id: questionnaire.id.to_s,
      title: questionnaire.title,
    })
  end
end