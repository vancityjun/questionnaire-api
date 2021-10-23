module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument
  end

  class QuestionAttributes < Types::BaseInputObject
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :type, String, required: false
    argument :_destroy, Boolean, required: false
  end

  class OptionAttributes < Types::BaseInputObject
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :_destroy, Boolean, required: false
  end
end
