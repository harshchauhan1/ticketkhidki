class BookingsController < ApplicationController
  
  before_filter :require_login, :only => :create

  def require_login
    if !session[:user_id]
      redirect_to login_url
    end
  end

  def create
    movie_show = MovieShow.find(params[:movie_show_id])
    seats = session[:seats]
    price_per_seat = params[:price_per_seat]
    total_price = session[:total]
    wallet = User.find_by_id(session[:user_id]).wallet
    balance = wallet.money - total_price
    success, transaction_id, booking = Booking.book_seats(movie_show, seats, total_price, wallet, balance, session[:user_id], price_per_seat)
    if success
      redirect_to movie_shows_path, :notice => "Your Transaction id is '#{transaction_id}'"
    else
      flash[:error] =  booking.errors.messages
      redirect_to request.referrer
    end
  end

  def index
    @bookings = Booking.where('user_id = ?', session[:user_id])
  end

  def new
  end
end
