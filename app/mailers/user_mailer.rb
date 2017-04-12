class UserMailer < ActionMailer::Base
	default :from => "noreplay@admin.com"
	binding.pry
	def registration_confirmation(user)
		@user = user
		mail(:to =>"#{user.name} <#{user.email}>",:subject => "please confirm u r registration")
	end
end