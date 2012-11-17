class Seat < ActiveRecord::Base
  attr_accessible :audi_id, :price, :seat_no, :seat_type, :status
  belongs_to :audi
  belongs_to :movie_show

  def self.total_price(seat_numbers, movie_show)
  	total_price = 0
  	seats = movie_show.seats
  	seat_numbers.each do |num|
  		seat = seats.find_by_seat_no(num)
  		total_price = total_price + seat.price
      logger.info(seat.price)
  	end
  	total_price
  end
  # seat.update_attribute(:status, true)
end
