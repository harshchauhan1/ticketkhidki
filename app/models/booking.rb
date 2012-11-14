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

  def self.book_seats(seats, movie_show)
  	movie_show.seats.where("seat_no in (#{seats.join(',')})").update_all(:status => true)
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
