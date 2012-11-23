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
		@audi = Audi.find(@movie_show.audi_id)
		@theatre = @audi.theatre.location
		@movie_date = session[:movie_date]
    	@seats = @audi.seats.pluck(:seat_no)
    	@timing = @movie_show.timing.strftime("%H:%M")
    	@booked_seats = @movie_show.bookings.pluck(:seat_num)
	end

	def create
		
	end

	def confirm_booking
	      	if params[:selected_seats]
	  			@seats = params[:selected_seats]
	    		@movie_show = MovieShow.find(params[:movie_show_id])
	    		@audi_id = @movie_show.audi.id  
	    		@total_price, @price_per_seat = Seat.total_price(@seats, @audi_id)
	        	session[:seats] = @seats
	        	session[:total] = @total_price
	        else	        	
	        	@error = "Please select seats" 
	      	end
	end
end
