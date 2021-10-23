module Mutations
  class Login < Mutations::BaseMutation
    graphql_name 'LoginUser'

    argument :email, String, required: true
    argument :password, String, required: false
    argument :last_name, String, required: false

    field :errors, [String], null: true
    field :user, Types::UserType, null: false

    def resolve(email:, last_name:, password:)
      user = nil

      if email.present?
        user = User.find_by(email: email.downcase)
      elsif last_name.present?
        user = User.find_by(last_name: last_name)
      end

      errors = []
      if user.blank?
        errors << 'User not found'
      elsif user.password != password
        errors << 'Incorrect password'
        user = nil
      end
      context[:current_user] = user
      {
        user: user,
        errors: errors
      }
    end
  end
end
