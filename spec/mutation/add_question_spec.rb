require 'rails_helper'

RSpec.describe Mutations::AddQuestion, type: :request do
  let!(:user) {create :user}
  let!(:questionnaire) {create :questionnaire, user: user}

  it 'create question and return questionnaire' do
    query = <<-GQL
      mutation addQuestion ($input: AddQuestionInput!) {
        addQuestion (input: $input){
          questionnaire{
            id
            title
            questions {
              id
              title
              questionType
            }
          }
        }
      }
    GQL

    variables = {
      questionnaireId: questionnaire.id,
      title: 'where should we go?',
      questionType: 'multiple-select'
    }

    result = ServerSchema.execute(
      query,
      variables: {input: variables},
      context: {current_user: user}
    ).to_h.deep_symbolize_keys[:data][:addQuestion]
    question = questionnaire.reload.questions.last

    expect(result[:questionnaire]).to match({
      id: questionnaire.id.to_s,
      title: questionnaire.title,
      questions: match_array([
        {
          id: question.id.to_s,
          title: question.title,
          questionType: question.question_type,
        }
      ])
    })
  end
end