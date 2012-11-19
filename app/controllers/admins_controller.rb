class AdminsController < ApplicationController
	before_filter :require_admin

	def require_admin
		if !session[:admin] 
			flash[:error] = "You were trying to view a page you are not authorized to view."
			redirect_to shows_path
		end
	end
		
	def show
		@theatres = Theatre.scoped
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
			 @movie_booking_info = movie.bookings
		end
	end

	def create_theatre_log
		theatre = Theatre.find_by_location(params[:theatre])
		date = params[:date_for_revenue].to_date
		@report = Booking.theatre_revenue_report(theatre, date)
	end

	def theatre_log
		
	end
end