module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Finds current user, if logged in
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Is there a logged in user, i.e. current_user != nil
  def logged_in?
    !current_user.nil?
  end
end
