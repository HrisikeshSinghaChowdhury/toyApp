class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from ActionController::InvalidAuthenticityToken do
    # @exception = exception.message
    render 'shared/500', :status => 200
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
