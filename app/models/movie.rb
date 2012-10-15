class Movie < ActiveRecord::Base
  attr_accessible :genre, :name, :release_date
  has_many :movie_shows
  has_and_belongs_to_many :theatres
  def self.movie_arr
  	all.collect{|movie| movie.name}
  end
  def self.movie_details (movie_name)
  	movie = Movie.find_by_name(movie_name)
    theatres = Theatre.all
    movie_shows = movie.movie_shows
    loc = []
    listing = Hash.new(Array.new)
      theatres.each do |t|
        movie_shows.each do |m|
          if t.id == m.audi.theatre.id
            loc.push(m.timing.strftime("%H" ":" "%M"))
          end
        end
        listing[t.location] = loc
        loc = []
      end
    return [movie_shows,listing]
  end
end