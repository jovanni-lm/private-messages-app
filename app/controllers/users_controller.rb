class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:create]

  def index
    @users = User.all.where.not(id: current_user, blocked: true)
  end

  def show
    @user = User.find(params[:id]).decorate

    @dialog = ([@user.dialogs, current_user.dialogs].inject(:&)).first

    @message_dialog_form = MessageDialogForm.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Successfully created User.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id]).decorate
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(user_params)
      flash[:notice] = 'Successfully updated User.'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :admin, :blocked)
  end
end
