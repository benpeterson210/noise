class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: {minimum: 2}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {minimum: 6}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
end
