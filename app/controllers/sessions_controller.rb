class SessionsController < ApplicationController
  def new
  end
  def create
  	user = User.find_by_email(params[:email])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
      session[:admin] = user.is_admin
      redirect_to after_sign_in_path
  	else
      flash[:error] = "Invalid user/password combination"
  		redirect_to login_url
  	end
  end
  def destroy
  	reset_session
  	redirect_to movie_shows_url, notice: "Logged out"
  end
end