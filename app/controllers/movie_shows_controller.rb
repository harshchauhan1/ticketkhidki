class MovieShowsController < ApplicationController
	before_filter :require_user


	def require_user
		if session[:admin] 
			flash[:error] = "You were trying to view a page you are not authorized to view."
			redirect_to after_sign_in_path
		end
	end
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
		@listing_by_theatre = []
		@listing_by_movie = []
		if(params[:movie] == "")
			@listing_by_theatre = Movie.movie_listing_by_theatre(params[:theatre], params[:movie_date])
		else
			logger.info("hello in movie list")
			@listing_by_movie = Movie.movie_listing_by_movie(params[:movie], params[:movie_date])
		end
		session[:movie_name] = params[:movie]
		session[:movie_date] = params[:movie_date]
	end

	
end