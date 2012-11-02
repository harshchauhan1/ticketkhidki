class SeatsController < ApplicationController
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
