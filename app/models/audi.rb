class Audi < ActiveRecord::Base
  attr_accessible :capacity, :theatre_id
  belongs_to :theatre
  validates :theatre_id, :presence => true
  has_many :seats, :dependent => :destroy
  has_many :movie_shows,  :dependent => :destroy

  after_create :add_seats_to_audi

  
  def add_seats_to_audi
  	seat_type = ["platinum", "gold", "silver"]
    seat_num = ["A", "B", "C"]
    price = [250, 200, 150]
    (0..2).each do |i|
      (1..5).each do |j|
        self.seats.create(:seat_no => seat_num[i] +  (j).to_s, :seat_type => seat_type[i], :price => price[i])
      end
    end
  end
end
