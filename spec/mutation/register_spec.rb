require 'rails_helper'

RSpec.describe Mutations::Register, type: :request do

  it 'register and return user' do
    query = <<-GQL
      mutation register ($input: RegisterInput!) {
        register (input: $input){
          user{
            token
            id
            email
            lastName
            firstName
          }
        }
      }
    GQL

    variables = {
      lastName: 'Jun',
      password: '1234'
    }
    result = ServerSchema.execute(
      query,
      variables: {input: variables},
    ).to_h.deep_symbolize_keys[:data][:register]
    user = User.last

    expect(result[:user]).to match({
      id: user.id.to_s,
      token: kind_of(String),
      email: user.email,
      lastName: user.last_name,
      firstName: user.first_name
    })
  end
end