require 'rails_helper'

RSpec.describe Mutations::RemoveQuestionnaire, type: :request do
  let!(:user) {create :user}
  let!(:questionnaire) {create :questionnaire, user: user}
  let!(:question) {create :question, questionnaire: questionnaire}
  let!(:options) {create_list :option, 5, question: question, voters: [user]}

  it 'removes questionnaire and its dependencies' do
    query = <<-GQL
      mutation removeQuestionnaire ($input: RemoveQuestionnaireInput!) {
        removeQuestionnaire (input: $input){
          message
        }
      }
    GQL

    variables = {
      id: questionnaire.id,
    }

    result = nil
    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:removeQuestionnaire]
    end.
      to change(user.reload.questionnaires, :count).by(-1).
      and change(Question, :count).by(-1).
      and change(Option, :count).by(-5).
      and change(VoteCount, :count).by(-5)
    
    expect(result[:message]).to eq('Successfully deleted')
  end
end