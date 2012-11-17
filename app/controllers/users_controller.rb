class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
      if @user.save
        Emailer.user_registered(@user.email, "welcome to ticketkhidki", @user.id).deliver
        return if request.xhr?
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
        if user.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
          redirect_to shows_url
        else
          flash[:error] = user.errors
          render 'users/change_password'
        end
    else
      flash[:error] = "Invalid current password"
      render 'users/change_password'
    end
  end
end