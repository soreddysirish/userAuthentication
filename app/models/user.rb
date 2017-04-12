require 'bcrypt'
class User < ApplicationRecord
	include BCrypt
	before_create :confirmation_token
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
	def email_activate 
		binding.pry
		self.email_confirmed =true
		self.confirm_token =nil
		save!(:validate =>false)
	end

	private 
	 def confirmation_token
	 	if self.confirm_token.blank?
	 		self.confirm_token =SecureRandom.urlsafe_base64.to_s
	 	end
	 end

end
