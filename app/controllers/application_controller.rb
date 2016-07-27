class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def admin?
    user = User.where(id: current_user.id).first
    user.role == "admin"
  end
  helper_method :admin?

  # def user_voted?(review)
  #   Vote.where(user_id: current_user.id, review_id: review.id)
  # end
  # helper_method :user_voted?
  #
  # def user_voting_status(review)
  #   voting_status = "None"
  #   if user_signed_in? && has_user_voted?(review)
  #     vote = Vote.where(user_id: current_user.id, review_id: review.id).first
  #     voting_status = "Up Voted" if vote.up_vote == true
  #     voting_status = "Down Voted" if vote.down_vote == true
  #   end
  #   voting_status
  # end
  # helper_method :user_voting_status
end
