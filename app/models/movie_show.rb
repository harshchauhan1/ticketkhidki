class MovieShow < ActiveRecord::Base
  attr_accessible :audi_id, :movie_id, :timing
  belongs_to :movie
  belongs_to :audi
  has_many :seats, :dependent => :destroy
  has_many :bookings, :dependent => :destroy
  
  #after_create :add_seats_to_show

Seat_type = ["platinum", "gold", "silver"]
Price = [250, 200, 150]
  def add_seats_to_show
  	i = 1
    (1..15).each do |i|
        self.seats.create(:seat_no => i, :seat_type => Seat_type[i/5], :price => Price[i/5])
      # elsif i < 11)
    end
  	# while i <= 15
  	# 	# if i < 6
  	# 	# 	#m.seats.create(:seat_no => i, :seat_type => "platinum", :price => 250)
  	# 	# elsif i < 11
  	# 	# 	m.seats.create(:seat_no => i, :seat_type => "gold", :price => 200)
  	# 	# else
  	# 	# 	m.seats.create(:seat_no => i, :seat_type => "silver", :price => 150)
  	# 	# end
  	# 	  i = i + 1
  	# end
  end

  def self.add_show *args
    require "time"
    audi = Audi.find(args[1])
    movie = Movie.find_by_name(args[2])
    show_time = "11/12/2012 09:00"
     timing = DateTime.parse(show_time)
    if !movie
      Movie.create(:name => args[2])
    end
    # if MovieShow.where("audi_id = ? AND timing =?", args[1], timing)
    #   return false
    # end
     logger.info(timing)
    show = movie.movie_shows.create(:timing => timing)
     audi.movie_shows << show
     return true
  end 

end