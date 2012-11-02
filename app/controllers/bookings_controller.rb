class BookingsController < ApplicationController
  
  def create
    movie_show = MovieShow.find(params[:movie_show_id])
    @seats = session[:seats]
    total_price = session[:total]
    @wallet = User.find_by_id(session[:user_id]).wallet
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
      Emailer.contact(booking.user.email, "Your booking details", "#{booking.id}").deliver
      return if request.xhr?
      redirect_to shows_path, :notice => "Your Booking id is #{booking.id}"
	  else
		 flash[:error] = "Sorry you have insufficient money." 
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
    Rails.logger.info(@bookings.inspect)
  end

  def new
  end
end
