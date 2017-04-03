require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  # before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :html, :js

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  protected
  #
  # def configure_permitted_parameters
  #   added_attrs = [:username, :email, :password, :password_confirmation, :admin, :blocked]
  #   devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  #   devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  # end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
end
