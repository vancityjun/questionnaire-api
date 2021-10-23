class User < ApplicationRecord  
  has_many :questionnaires, dependent: :destroy
  has_many :vote_counts
  has_many :options, through: :vote_counts
  
  attr_encrypted :password, key: 'This is a key that is 256 bits!!'
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: proc {|attributes| attributes[:email].present?}

  before_save :lowercase_email, if: :email =~ /[A-Z]/

  def full_name
    "#{first_name} #{last_name}"
  end

  def token
    JWT.encode(for_token, nil, 'none')
  end

private

  def for_token
    {
      user_id: id,
      user_email: email
    }
  end

  def lowercase_email
    self.email = email.downcase
  end
end
