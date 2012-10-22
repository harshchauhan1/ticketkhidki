class BookingsController < ApplicationController
  
  def create
  	if session[:user_id]
      if params[:selected_seats]
  			@seats = params[:selected_seats]
    		@var = Booking.details()
    		@wallet = User.find_by_id(session[:user_id]).wallet
    		movie_show = MovieShow.find(params[:movie_show_id])
    		total_price = Seat.total_price(@seats, movie_show)
        balance = @wallet.money - total_price
  		  if @seats.any? && balance >= 0 
          @wallet.update_attribute(:money, balance)
          admin_wallet = User.where('is_admin = ?', true).first.wallet
          admin_wallet.update_attribute(:money, (admin_wallet.money + total_price))
          booking = Booking.new
          booking.user_id = session[:user_id]
          booking.movie_show_id = params[:movie_show_id]
          booking.sub_total = total_price
          booking.seat_num = @seats.join(',')
          booking.save
    			Booking.book_seats(@seats, movie_show)
          Emailer.contact(User.find_by_id(booking.user_id).email, "your booking", "#{booking.inspect}").deliver
          return if request.xhr?
          redirect_to shows_path, :notice => "Your Booking id is #{booking.id}"
  		  else
  			 flash[:error] = "Sorry you have insufficient money." 
  		  end
      else
        flash[:error] = "Please select seats" 
        redirect_to request.referrer
      end
		else
			redirect_to login_url
		end
  end

  def destroy
  end

  def index
    if session[:admin]
      @bookings = Booking.all
    else
      @bookings = Booking.where('user_id = ?', session[:user_id])
    end
  end

  def new
  end
end
