class ShowsController < ApplicationController
	before_filter {  if session[:admin] 
		flash[:error] = "You are not authorized to view this page."
		redirect_to admin_path(session[:user_id])
	end
		}
	def index
		@movies = Movie.all
    	@date = Date.today
    	respond_to do |format|
    		format.html
    		format.js
    	end
    	@movie_shows = []
	end
	def movie_list
		@location = Movie.movie_details(params[:movie])
		session[:movie] = params[:movie]
		session[:movie_date] = params[:movie_date]
				
	end
end