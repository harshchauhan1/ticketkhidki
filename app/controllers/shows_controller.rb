class ShowsController < ApplicationController
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
		@movie_shows,@location = Movie.movie_details(params[:movie])
	end
end