class SessionsController < ApplicationController
  def new
  end
  def create
  	user = User.find_by_email(params[:email])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to main_index_url
  	else
  		redirect_to login_url, alert: "Invalid user/password combination"
  	end
  end
  def destroy
  	session[:user_id] = nil
  	redirect_to main_index_url, notice: "Logged out"
  end
end