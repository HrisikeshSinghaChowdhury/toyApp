class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create edit destroy update index show]
  # before_action :chk_access, only: %i[ edit update destroy show ]
  before_action :chk_access, only: %i[ index ]

  # GET /microposts or /microposts.json
  def index
    @microposts = current_user.microposts
  end

  # GET /microposts/1 or /microposts/1.json
  def show
    @micropost =  Micropost.find(params[:id])
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
    @micropost = Micropost.find(params[:id])
  end

  # POST /microposts or /microposts.json
  def create
    @micropost = Micropost.new
    @micropost = current_user.microposts.build(micropost_params) if logged_in?

    @micropost.save
    # # respond_to do |format|

    #   if @micropost.nil? && @micropost.save
    #     format.js
    #   else
    #     #redirect_to new_micropost_url
    #   end
    # end
  end

  # PATCH/PUT /microposts/1 or /microposts/1.json
  def update
    @micropost = Micropost.find(params[:id])
    @micropost.update_columns(content: micropost_params[:content])
  end

  # DELETE /microposts/1 or /microposts/1.json
  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    flash[:success] = "Micropost was successfully destroyed."
    redirect_to microposts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def micropost_params
      params.require(:micropost).permit(:id, :user_id, :content)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
      #  @micropost = Micropost.find(params[:id])
    end

    def chk_access
      # @micropost = Micropost.find(params[:id])
      @microposts = current_user.microposts
      if @microposts.first.user_id != current_user.id
        flash[:danger] = "Authoriztion failed"
        redirect_to shared/error_authorization
      end
    end
end
