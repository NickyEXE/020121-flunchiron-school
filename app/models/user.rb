class User < ApplicationRecord
  has_secure_password
  has_many :reviews
  has_many :restaurants, through: :reviews
  validates :username, :email, uniqueness: true
  validates :username, :email, presence: true
  validates :zip_code, numericality: {greater_than_or_equal_to: 10001, less_than_or_equal_to: 99999}


end
