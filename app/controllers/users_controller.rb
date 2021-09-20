class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[ show edit update ]
  before_action :chk_access, only: %i[ show edit update ]
  before_action :set_user, only: :destroy
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(session[:user_id])
  end

  # GET /users/new
  def new
    @user = User.new

  end

  # GET /users/13/edit
  def edit
  end

  # remove avatar attach (pic upload) from sign up page(2nd demo)

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.avatar.attach(user_params[:avatar])

    if @user.save
      flash[:success] = "Sign Up Process Successfull.Welcome #{@user[:name]} to the QI Blog.Please Login to Continue"
      redirect_to user_path current_user
    else
      flash[:danger] = "Oops something went wrong"
      render 'new'
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update

    @user.avatar.attach(user_params[:avatar])

    if @user.update_columns(name: user_params[:name])
      flash[:success] = "User was successfully updated."
      redirect_to user_path(@current_user)
    else
      flash[:danger] = "Sorry Something went wrong"
      redirect_to login_url
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if @user.avatar.destroy
        flash[:success] = "Profile picture successfully removed."
    else
        flash[:danger] = "Oops smething went wrong"
    end
    redirect_to user_path current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      if !params.nil?
        params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :avatar)
      end
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
      @user = User.find(params[:id])
    end

    def chk_access
      if @user.id != current_user.id
        flash[:danger] = "Authoriztion failed"
        render 'shared/error_authorization'
      end
    end

    def delete_avatar

    end
end
