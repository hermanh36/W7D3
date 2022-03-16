class ApplicationController < ActionController::Base

  def current_user
    user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
    logged_in?
  end

  def login(user)
    session[:session_token] = user.reset_session_token
  end

  def logout
  end


end
