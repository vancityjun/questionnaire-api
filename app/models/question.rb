class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: proc {|attributes| attributes[:title].blank?}
end