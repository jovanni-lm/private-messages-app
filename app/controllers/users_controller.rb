class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @message_dialog_form = MessageDialogForm.new
  end
end
