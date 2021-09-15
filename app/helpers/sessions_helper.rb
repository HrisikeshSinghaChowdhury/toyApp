module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:user_email] = user.email
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_micropost_user_id
    @current_micropost_user_id ||= Micropost.find_by(user_id: session[:user_id])
  end
end
