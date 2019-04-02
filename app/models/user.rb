class User < ApplicationRecord
  has_many :sessions
  has_many :tasks

  validates :username, length: { maximum: 64, minimum: 3 }, presence: true, uniqueness: true
  validates :password, length: { maximum: 64, minimum: 8 }, presence: true

end
