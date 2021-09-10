class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      log_in user
      flash[:success] = "Hii #{user[:name]} successfully logged in.Session started"
      redirect_to user_path(user.id)
    else
      flash[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    flash[:success] = "Bye successfully logged out.Session ended"
    session.destroy
    redirect_to root_url
  end
end
