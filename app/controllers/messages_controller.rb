class MessagesController < ApplicationController
  def new
    @message_dialog_form = MessageDialogForm.new
  end

  def create
    @message_dialog_form = MessageDialogForm.new(message_dialog_form_params)

    if @message_dialog_form.save
      redirect_to user_path(message_dialog_form_params[:recipient])
    else
      render 'new'
    end
  end

  private
  def message_dialog_form_params
    params.require(:message_dialog_form).permit(:body, :sender, :recipient)
  end
end
