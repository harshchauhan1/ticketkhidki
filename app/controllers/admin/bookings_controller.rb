class Admin::BookingsController < ApplicationController
  layout 'admin'
  
 before_filter :require_admin


  def require_admin
    unless session[:admin] 
      redirect_to after_sign_in_path, notice: "You are not authorized"
    end
  end

  def index
    @bookings = Booking.scoped
  end

  def log_by_user
    @user_booking_info = []
    user = User.find_by_name(params[:user])
    @user_booking_info = user.bookings
  end

  def log_by_movie
    @movie_booking_info = []
    movie = Movie.find_by_name(params[:movie])
    @movie_booking_info = movie.bookings    
  end

  def log
    @theatre = Theatre.scoped
  end


end
