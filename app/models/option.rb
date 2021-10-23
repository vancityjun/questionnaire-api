class Option < ApplicationRecord
  has_many :vote_counts, dependent: :destroy
  has_many :voters, through: :vote_counts, source: :voter
  belongs_to :question
end