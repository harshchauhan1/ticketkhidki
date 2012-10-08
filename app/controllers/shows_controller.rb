class ShowsController < ApplicationController
	def index
		@movie_shows = MovieShow.all
	end
end