class SeatsController < ApplicationController
	def index
		@movie_show = MovieShow.find(params[:movie_show_id])
		@movie_date = session[:movie_date]
    @seats = @movie_show.seats.where('status = "t"').collect(&:seat_no)
	end

	def create
		
	end
end
