class VoteCount < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :option
end