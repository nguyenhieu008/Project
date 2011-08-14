class UsersController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	def new
		@title = "Sign up"
	end
	
	def show
		@user = User.find(params[:id])
	end
	def edit
		@user = User.find(params[:id])
		@tittle = "Edit user"
	end
	def update
		@user = User.find(params[:id])
		@user.name = params[:user][:name]
		@user.email = params[:user][:email]
		@user.password = "fakepass"
		@user.password_confirmation = "fakepass"
		@user.check = 0
		if @user.save
			flash[:succes] = "Profile updated"
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end
	
	private
		
		def authenticate
			deny_access unless signed_in?
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
end
