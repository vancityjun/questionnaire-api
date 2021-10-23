require 'rails_helper'

RSpec.describe Mutations::RemoveQuestion, type: :request do
  let!(:user) {create :user}
  let!(:questionnaire) {create :questionnaire, user: user}
  let!(:question) {create :question, questionnaire: questionnaire}
  let!(:options) {create_list :option, 5, question: question, voters: [user]}

  it 'removes question and its options' do
    query = <<-GQL
      mutation removeQuestion ($input: RemoveQuestionInput!) {
        removeQuestion (input: $input){
          message
        }
      }
    GQL

    variables = {
      questionnaireId: questionnaire.id,
      id: question.id,
    }

    result = nil

    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:removeQuestion]
    end.
      to change(questionnaire.reload.questions, :count).by(-1).
      and change(Option, :count).by(-5).
      and change(VoteCount, :count).by(-5)

    expect(result[:message]).to eq('Successfully deleted')
  end
end