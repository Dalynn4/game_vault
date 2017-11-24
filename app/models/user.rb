class User < ActiveRecord::Base
  has_many :consoles
  has_many :games
  has_secure_password
  validates :username, :password, presence: true
end
