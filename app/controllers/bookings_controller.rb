class BookingsController < ApplicationController
  
  def create
    movie_show = MovieShow.find(params[:movie_show_id])
    seats = session[:seats]
    total_price = session[:total]
    wallet = User.find_by_id(session[:user_id]).wallet
    balance = wallet.money - total_price
    success, booking = Booking.book_seats(movie_show, seats, total_price, wallet, balance, session[:user_id])
    if success
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
