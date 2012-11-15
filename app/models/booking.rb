class Booking < ActiveRecord::Base
  attr_accessible :seat_num, :show_id, :sub_total, :user_id
  belongs_to :user
  belongs_to :movie_show

  def self.details ()
  	m = MovieShow.first.seats.first
  	m.status = false
  	m.save
  	return m
  end

  def self.book_seats(movie_show, seats, total_price, wallet, balance, user_id)
    if seats.any? && balance >= 0
      wallet.update_attribute(:money, balance)
      admin_wallet = User.where('is_admin = ?', true).first.wallet
      admin_wallet.update_attribute(:money, (admin_wallet.money + total_price))
      booking = Booking.new
      booking.user_id = user_id
      booking.movie_show_id = movie_show.id
      booking.sub_total = total_price
      booking.seat_num = seats.join(',')
      booking.save
      movie_show.seats.where("seat_no in (#{seats.join(',')})").update_all(:status => true)
      return true, booking
    else
     return false
    end
  end

  def self.theatre_revenue_report(movies)
    @shows = []
    @bookings = []
    total = 0
    movies.each do |movie|
      @shows << movie.movie_shows
      @shows.each do |show|
        @boookings << show.bookings
      end
    end
    return @shows 
  end
end
