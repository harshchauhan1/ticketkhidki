class SessionsController < ApplicationController
  def new
  end
  def create
  	user = User.find_by_email(params[:email])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
      redirect_to shows_url
  		#redirect_to user_url(user.id)
  	else
  		redirect_to login_url, alert: "Invalid user/password combination"
  	end
  end
  def destroy
  	session[:user_id] = nil
  	redirect_to shows_url, notice: "Logged out"
  end
  def index
    @movies = Movie.all
    @date = Date.today
  end
end