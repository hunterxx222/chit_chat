class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  protected

  def current_user
    return @current_user if @current_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
    end
  end

  def require_user!
    unless current_user
      redirect_to new_session_path, flash: {success: "Please login first"}
    end
  end
end
