class User < ApplicationRecord
	before_save {self.email = email.downcase}
	validates :name, presence: true, length: {maximum: 9}
	validates :email, presence: true, length: {maximum: 15}, format: {with: /[@]/}, uniqueness: {case_sensitive: false}
	   
	has_secure_password
	validates :password, presence: true, length:{minimum: 5}	
end
