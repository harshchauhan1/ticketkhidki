class SeatsController < ApplicationController
	before_filter :require_user


	def require_user
		if session[:admin] 
			flash[:error] = "You were trying to view a page you are not authorized to view."
			redirect_to admin_path(session[:user_id])
		end
	end
	def index
		@movie_show = MovieShow.find(params[:movie_show_id])
		@movie_date = session[:movie_date]
    @seats = @movie_show.seats.where('status = "t"').collect(&:seat_no)
	end

	def create
		
	end

	def confirm_booking
		if session[:user_id]
	      	if params[:selected_seats]
	  			@seats = params[:selected_seats]
	    		@var = Booking.details()
	    		@movie_show = MovieShow.find(params[:movie_show_id])
	    		@total_price = Seat.total_price(@seats, @movie_show)
	        	session[:seats] = @seats
	        	session[:total] = @total_price
	        else	        	
	        	@error = "Please select seats" 
	      	end
		else
		  @path =  login_url
		end

	end
end
