class AdminController < ApplicationController
	layout 'admin'
	before_filter :require_admin

	def require_admin
		if !session[:admin] 
			flash[:error] = "You were trying to view a page you are not authorized to view."
			redirect_to root_path
		end
	end
	
	def dashboard
		@theatres = Theatre.scoped
	end
	def index		
	end


	def log_list
		
	end

	

end