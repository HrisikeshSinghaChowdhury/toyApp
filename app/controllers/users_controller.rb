class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[ show edit update ]

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

  # GET /users/1/edit
  def edit
    if current_user != session[:user_id]
      flash[:danger] = "Unauthorized Access"
      redirect_to login_path
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

      if @user.save
        flash[:success] = "Sign Up Process Successfull.Welcome #{@user[:name]} to the QI Blog.Please Login to Continue"
        redirect_to login_url
      else
        # => format.html { render :new, status: :unprocessable_entity }
        # => format.json { render json: @user.errors, status: :unprocessable_entity }
        render 'new'
      end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update_columns(name: user_params[:name])
      flash[:success] = "User was successfully updated."
      redirect_to login_url
    else
      flash[:danger] = "Sorry Something went wrong"
      redirect_to login_url
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
      @user = User.find(params[:id])
    end
end
