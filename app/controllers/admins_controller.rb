class AdminsController < ApplicationController
	before_filter :require_admin

	def require_admin
		if !session[:admin] 
			flash[:error] = "You were trying to view a page you are not authorized to view."
			redirect_to shows_path
		end
	end
		
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
		nnn
		@theatre = params[:theatre]
		@movie = params[:movie]
		@show_time = params[:showtime]
		theatre = Theatre.find_by_location(@theatre)
		theatre.movies.create(:name => "@movie")
		m = Movie.last
		m.movie_shows.create(:timing => @show_time)
	end

	def create_theatre_log
		theatre = Theatre.find_by_location(params[:theatre])
		m = theatre.movies
		m.each do |movie|
			@shows << movie.movie_shows
		end
	end

	def theatre_log
	end
end