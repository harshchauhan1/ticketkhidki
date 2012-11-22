class UsersController < ApplicationController
  before_filter :change_layout

  def change_layout
    if session[:admin]
      self.class_eval {
        layout 'admin'
      }
    end
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
        if user.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
          redirect_to after_sign_in_path, notice: "Your password has been sucessfully changed."
        else
          flash[:error] = user.errors.messages
          render 'users/change_password'
        end
    else
      flash[:error] = "Invalid current password"
      render 'users/change_password'
    end
  end
end