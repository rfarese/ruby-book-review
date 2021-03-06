class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def admin?
    if user_signed_in?
      user = User.where(id: current_user.id).first
      return user.role == "admin"
    else 
      return false
    end
  end
  helper_method :admin?
end
