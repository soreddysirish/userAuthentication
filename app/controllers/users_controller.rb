class UsersController < ApplicationController
	before_action :check_user,only: [:index]
	before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only: [:destroy]

  def index
  	@users =User.paginate(page: params[:page],per_page:10)
  end

  def new
    @user =User.new
  end

  def create 
    @user =User.new(user_params)
    if @user.save
      binding.pry
      UserMailer.registration_confirmation(@user).deliver_now
      binding.pry
      flash[:success] ="User is successfully saved"
      redirect_to @user
    else
      render "new"
    end
  end

  def confirm_email
    user =User.find_by_confirm_token(params[:id])
    binding.pry
    if user
       user.email_activate
      flash[:success] ="u r account is confirmed"
      redirect_to root_url
    else
      flash[:error] ='user doesnt exist'
      redirect_to root_url
    end
  end


  def show
    @user =User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

	def update
		@user =User.find(params[:id])
		if @user.update(user_params)
			binding.pry
			flash[:success] ="user is successfully updated"
			redirect_to users_path
		else
			render "edit"
		end
	end

  def destroy
    @user =User.find(params[:id])
  if current_user.admin
      @user.destroy
        flash[:success] ="users deleted successfully"
        redirect_to users_path
      end
   
  end

  private
  def user_params
  	params.require(:user).permit(:name,:email,:password,:password_confirmation,:email_confirmed)
  end

  def check_user
  	if !user_login
  		flash[:danger] ="Please login to continue"
  		redirect_to root_path
  	end 
  end
  def admin_user
    redirect_to (users_path) unless current_user.admin?
  end

  def correct_user
  	@user =User.find(params[:id])
  	if @user != current_user
  		flash[:danger] ="Don't change other users data"
  	end
  	redirect_to("/") unless @user == current_user
  end
end
