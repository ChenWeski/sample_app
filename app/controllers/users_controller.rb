class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  

  def new
  	@user = User.new
  end

  def destroy
  	User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  	
  end

   def show
   	@user = User.find(params[:id])
	end

	def create
   		@user = User.new(user_params)   	
   		if @user.save
   			flash[:success] = "Welcome to the Sample App!"
   			login @user
   			redirect_to @user
   		else
   			render 'new'
   		end
	end

	def edit
		
		@user = User.find(params[:id])
		
	end

	def update
		
		@user = User.find(params[:id])	
		if @user.update_attributes(user_params)			   
			flash[:success] = 'update succeeded';
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index
		@users = User.all
		
	end

	def user_params		
		params.require(:user).permit(:name, :email, :password, :password_confirmation)		
	end

	def logged_in_user
		unless logged_in? 
			storing_url
			flash[:danger] = 'login first'
			redirect_to login_path
		end
	end

	def correct_user		
		unless current_user.id.to_s == params[:id]
			flash[:danger] =  'this is not the correct user' 
			redirect_to root_url
		end
		
	end

	def admin_user
		redirect_to root_url unless current_user.administrator?		
	end

end
