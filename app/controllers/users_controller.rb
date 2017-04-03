class UsersController < ApplicationController
  load_and_authorize_resource except: [:message_counter]
  skip_load_resource only: [:create]

  def index
    @users = User.all.decorate
  end

  def show
    @user = User.find(params[:id]).decorate

    @dialog = [@user.dialogs, current_user.dialogs].inject(:&).first

    if @dialog.present?
      @dialog.messages.each do |message|
        MessageMarkAsRead.new(message, current_user).mark_as_read!
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_create_params)
    respond_with @user, location: root_path
  end

  def edit
    @user = User.find(params[:id]).decorate
  end

  def update
    @user = User.find(params[:id]).decorate

    @user.update_attributes(user_update_params)
    respond_with @user, location: root_path
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'Successfully deleted User.'
      redirect_to root_path
    end
  end

  def message_counter
    @counter = MessagesCounter.new(UserNewMessages, current_user).html

    respond_to do |format|
      format.js
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:username, :email, :password, :admin, :blocked)
  end

  def user_update_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? && params[:user][:password_confirmation].blank?

    params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin, :blocked)
  end
end
