require 'rails_helper'

RSpec.describe Mutations::Vote, type: :request do
  let!(:user) {create :user}
  let!(:questionnaire) {create :questionnaire, user: user}
  let!(:question) {create :question, questionnaire: questionnaire}
  let!(:options) {create_list :option, 5, question: question}

  it 'add user to the option as a voter' do
    query = <<-GQL
      mutation vote ($input: VoteInput!) {
        vote (input: $input){
          question {
            id
            title
            questionType
            options {
              id
              title
              voters {
                fullName
              }
            }
          }
        }
      }
    GQL

    variables = {
      questionId: question.id,
      optionIds: options.first(3).pluck(:id),
    }

    result = ServerSchema.execute(
      query,
      variables: {input: variables},
      context: {current_user: user}
    ).to_h.deep_symbolize_keys[:data][:vote]

    expect(result[:question]).to match({
      id: question.id.to_s,
      title: question.title,
      questionType: question.question_type,
      options: match(options_attributes question.options)
    })
  end

  def options_attributes(options)
    options.map do |option|
      {
        id: option.id.to_s,
        title: option.title,
        voters: match(voters_attributes option.voters)
      }
    end
  end

  def voters_attributes(voters)
    voters.map do |voter|
      {
        fullName: voter.full_name
      }
    end
  end
end