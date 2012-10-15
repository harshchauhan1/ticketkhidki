class UsersController < ApplicationController
	def index
		@users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
	end
	def show
    @user = User.find(params[:id])
    @movies = Movie.all
    @date = Date.today
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
      if @user.save
      redirect_to login_url
    else
      render :new
    end
  end
  def change_password
  end
  def save_password
    user = User.find(session[:user_id])
    if user && user.authenticate(params[:existing_password])
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.save
      redirect_to shows_url
    else
      redirect_to change_password_url, alert: "Invalid current password"
    end
  end
end