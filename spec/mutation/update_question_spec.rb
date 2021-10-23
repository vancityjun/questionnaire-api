require 'rails_helper'

RSpec.describe Mutations::UpdateQuestion do
  let!(:user) {create :user}
  let!(:questionnaire) {create :questionnaire, user: user}
  let!(:question) {create :question, questionnaire: questionnaire}
  let!(:options) {create_list :option, 5, question: question, voters: [user]}

  it 'update question and options but keep the voters from the options' do
    query = <<-GQL
      mutation updateQuestion ($input: UpdateQuestionInput!) {
        updateQuestion (input: $input){
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

    options_values = [
      {
        id: options[0].id,
        title: 'Cactus club'
      },
      {
        id: options[1].id,
        title: 'Boston Pizza'
      },
      {
        id: options[4].id,
        _destroy: true
      }
    ]

    variables = {
      id: question.id,
      title: 'where are we going?',
      questionType: 'multiple-select',
      optionsAttributes: options_values
    }

    result = nil
    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:updateQuestion]
    end.
      to change {question.reload.title}.to('where are we going?').
      and change {question.options.count}.by(-1).
      and change {question.options[0].title}.to('Cactus club').
      and change {question.options[1].title}.to('Boston Pizza')

    expect(result[:question]).to match({
      id: question.id.to_s,
      title: question.reload.title,
      questionType: question.question_type,
      options: match_array(options_attributes question.options)
    })
  end

  def options_attributes(options)
    options.map do |option|
      {
        id: option.id.to_s,
        title: option.title,
        voters: match_array(voters_attributes option.voters)
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