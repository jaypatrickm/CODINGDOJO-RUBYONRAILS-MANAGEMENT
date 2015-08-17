class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def new

	end
	def create
		@user = User.create( user_params )
		if @user.valid?
			redirect_to '/users/'
		else
			# @errors = @user.errors.messages
			@first_name_error = @user.errors.full_messages_for(:first_name) if @user.errors.messages.include?(:first_name)
			@last_name_error = @user.errors.full_messages_for(:last_name) if @user.errors.messages.include?(:last_name)
			@email_address_error = @user.errors.full_messages_for(:email_address) if @user.errors.messages.include?(:email_address)
			@password_error = @user.errors.full_messages_for(:password) if @user.errors.messages.include?(:password)
			render "new"
		end
	end
	def show
		@user = User.find(params[:id])
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		@user = User.find(params[:id])
		@user.assign_attributes( user_params )
		if @user.valid?
			@user.save
			redirect_to '/users/'+params[:id]
		else
			# @errors = @user.errors.messages
			@first_name_error = @user.errors.full_messages_for(:first_name) if @user.errors.messages.include?(:first_name)
			@last_name_error = @user.errors.full_messages_for(:last_name) if @user.errors.messages.include?(:last_name)
			@email_address_error = @user.errors.full_messages_for(:email_address) if @user.errors.messages.include?(:email_address)
			@password_error = @user.errors.full_messages_for(:password) if @user.errors.messages.include?(:password)
			render "edit"
		end
	end
	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to '/users/'
	end
	private 
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email_address, :password)
		end
end
