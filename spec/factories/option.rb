FactoryBot.define do
  factory :option do
    sequence(:title) { |n| "option #{n}" }
  end
end
