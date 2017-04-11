class SessionsController < ApplicationController
  
  def new
  end
  
def create 
	user =User.find_by(email:params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			flash[:success] ="user success fully login"
			login(user)
			redirect_to users_path
			else
				flash.now[:danger] ="please enter valid email and password"
			render 'new'
		end
	end

	def destroy
		logout
		 flash[:success] ="User successfully logged out"
	 redirect_to login_path
	end

end
