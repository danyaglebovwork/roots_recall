class User < ApplicationRecord
  has_many :flashbacks
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password :password, validations: false
end
