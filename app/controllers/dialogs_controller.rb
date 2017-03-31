class DialogsController < ApplicationController
  def new

  end

  def create

  end

  def show
    @dialog = Dialog.find(params[:id])
  end
end
