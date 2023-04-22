class User < ApplicationRecord
  before_save :lowercase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum:5, maximum: 50}
  validates :email, presence: true, length: {maximum: 70},
                    format: { with: VALID_EMAIL_REGEX}, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 5}

  def lowercase_email
    self.email = email.downcase
  end


end
