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
    total_price = session[:total]
    wallet = User.find_by_id(session[:user_id]).wallet
    balance = wallet.money - total_price
    success, booking = Booking.book_seats(movie_show, seats, total_price, wallet, balance, session[:user_id])
    if success
      redirect_to shows_path, :notice => "Your Booking id is #{booking.id}"
    else
      flash[:error] = "Sorry you have insufficient money." 
    end
  end

  def index
    @bookings = Booking.where('user_id = ?', session[:user_id])
  end

  def new
  end
end
