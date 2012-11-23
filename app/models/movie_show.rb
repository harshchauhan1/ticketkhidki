class MovieShow < ActiveRecord::Base
  attr_accessible :audi_id, :movie_id, :timing
  belongs_to :movie
  belongs_to :audi
  has_many :bookings, :dependent => :destroy
  validates :movie_id, :presence => true
  validates :timing, :uniqueness => {:scope => :audi_id, :message => "show already exists" }
  validate :timing_cannot_be_in_the_past



  def timing_cannot_be_in_the_past
    if timing < DateTime.now
      errors.add(:timing, "show_time has already passed")
    end
  end

  def self.add_show (theatre, audi, movie_name, show_tim_arr, date_to, date_from)
    audi = Audi.find(audi)
    movie = Movie.find_or_create_by_name(movie_name)
    theatre = Theatre.find(theatre)
    new_id = [movie.id] - theatre.movie_ids
    if movie && new_id.any?
      theatre.movies << movie
    end
    show = []
    date_from.to_date.upto(date_to.to_date) do |day|
      show_tim_arr.each do |show_time|
        timing = DateTime.parse(day.to_s + " " + show_time.to_s)
        show = movie.movie_shows.build(:timing => timing, :audi_id => audi.id)
        if !show.save
          return [false, show]
        end
      end
    end
    return [true, show]
  end 
end