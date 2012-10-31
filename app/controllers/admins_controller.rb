class AdminsController < ApplicationController
	def show
		
	end
	def index
		@bookings = Booking.all
	end

	def log_list
		@movie_booking_info = []
		@user_booking_info = []
		if params[:user]
			user = User.find_by_name(params[:user])
			@user_booking_info = user.bookings
		elsif params[:movie]
			movie = Movie.find_by_name(params[:movie])
			movieshows = movie.movie_shows
			movieshows.each do |show|
			 @movie_booking_info << show.bookings
			end
		end
	end

	def add_shows
	kjbk 
	end
end