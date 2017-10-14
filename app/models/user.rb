require 'bcrypt'
class User < ActiveRecord::Base
	include BCrypt
  has_many :posts
  has_many :comments
	has_many :votes
	validates :username, presence: true, uniqueness: true
	validates :username, exclusion: { in: %w(admin administrator superuser) }
	validates :password, presence: true, on: :create

	has_secure_password validations: false

end
