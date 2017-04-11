require 'bcrypt'
class User < ApplicationRecord
	 include BCrypt
	before_save {email.downcase!}
	validates :name,presence:true
	valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,
				presence:true, 
				length: {minimum:3},
				format: {with:valid_email_regex},
				uniqueness:{case_sensitive:false}
	validates :password, confirmation:true
	has_secure_password


end
