class UsersController < ApplicationController
before_action :authorize_user

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    flash[:notice] = "You've successfully removed the user"
    render "index"
  end

  protected
  def authorize_user
    if !user_signed_in? || current_user.role != "admin"
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
