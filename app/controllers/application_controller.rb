class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :shows

  def after_sign_in_path
  	if session[:admin]
  		admin_dashboard_url
  	else
  		movie_shows_url
  	end
  end
end
