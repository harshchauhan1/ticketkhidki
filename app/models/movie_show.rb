class MovieShow < ActiveRecord::Base
  attr_accessible :audi_id, :movie_id, :timing
  belongs_to :movie
  belongs_to :audi
  has_many :seats
  has_many :bookings
  
  after_create :add_seats_to_show


  def add_seats_to_show
  	m = MovieShow.last
  	i = 1
  	while i <= 15
  		if i < 6
  			m.seats.create(:seat_no => i, :seat_type => "platinum", :price => 250)
  		elsif i < 11
  			m.seats.create(:seat_no => i, :seat_type => "gold", :price => 200)
  		else
  			m.seats.create(:seat_no => i, :seat_type => "silver", :price => 150)
  		end
  		i = i + 1
  	end
  end
end