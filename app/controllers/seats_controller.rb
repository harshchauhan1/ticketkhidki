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
    	@seats = @movie_show.seats.where('status = "t"').collect(&:seat_no)
    	@timing = @movie_show.timing.strftime("%H:%M")
	end

	def create
		
	end

	def confirm_booking
	      	if params[:selected_seats]
	  			@seats = params[:selected_seats]
	    		@movie_show = MovieShow.find(params[:movie_show_id])
	    		@total_price = Seat.total_price(@seats, @movie_show)
	        	session[:seats] = @seats
	        	session[:total] = @total_price
	        else	        	
	        	@error = "Please select seats" 
	      	end
	end
end
