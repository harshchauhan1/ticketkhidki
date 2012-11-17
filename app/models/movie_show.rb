class MovieShow < ActiveRecord::Base
  attr_accessible :audi_id, :movie_id, :timing
  belongs_to :movie
  belongs_to :audi
  has_many :seats, :dependent => :destroy
  has_many :bookings, :dependent => :destroy
  
  after_create :add_seats_to_show

  Seat_type = ["platinum", "gold", "silver"]
  Price = [250, 200, 150]
  def add_seats_to_show
  	i = 1
    (0..14).each do |i|
        self.seats.create(:seat_no => i+1, :seat_type => Seat_type[i/5], :price => Price[i/5])
    end
  end

  def self.add_show (theatre, audi, movie_name, show_tim_arr, date_to, date_from)
    audi = Audi.find(audi)
    movie = Movie.find_by_name(movie_name)
     if (show_tim_arr.uniq.length != show_tim_arr.length)
      return "Select distinct show timings!"
    end
    if Date.parse(date_to) < Date.parse(date_from) 
      return "Invalid date selection!"
    end
    if !movie
      Movie.create(:name => movie_name)
    end
    # if MovieShow.where("audi_id = ? AND timing =?", args[1], timing)
    #   return false, "Show already exists"
    # end
    date_from.to_date.upto(date_to.to_date) do |day|
      show_tim_arr.each do |show_time|
        timing = DateTime.parse(day.to_s + " " + show_time.to_s)
        show = movie.movie_shows.create(:timing => timing)
        audi.movie_shows << show
      end
    end
    return "show added succesfully"
  end 

end