class Seat < ActiveRecord::Base
  attr_accessible :audi_id, :price, :seat_no, :seat_type
  validates :audi_id, :presence => true
  validates :price, :presence => true
  validates :seat_no, :presence => true

  belongs_to :audi
  belongs_to :movie_show

  def self.total_price(seat_numbers, audi_id)
  	total_price = 0
    price_per_seat = {}
  	seats = Audi.find(audi_id).seats
  	seat_numbers.each do |num|
  		seat = seats.find_by_seat_no(num)
  		total_price = total_price + seat.price
      price_per_seat[num.to_sym] = seat.price
      logger.info(seat.price)
  	end
  	[total_price, price_per_seat]
  end
end