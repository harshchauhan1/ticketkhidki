class Movie < ActiveRecord::Base
  attr_accessible :genre, :name
  validates :name, :presence => true
  validates :name, :uniqueness => :true
  has_many :movie_shows, :dependent => :destroy
  has_many :bookings, :through => :movie_shows
  has_and_belongs_to_many :theatres
  
  def self.movie_listing_by_movie (movie_name, movie_date)
    movie_date = movie_date.split(",")
    date = Date.parse(movie_date[1])
  	movie = Movie.find_by_name(movie_name)
    theatres = Theatre.scoped
    logger.info(theatres)
    shows = []
    listing = Hash.new(Array.new)
      theatres.each do |theatre|
        if theatre.movies.where('id = ?', movie.id).any?
          audi_ids = theatre.audis.collect(&:id)
          logger.info(audi_ids)
          shows = theatre.movies.where('id = ?', movie.id)[0].movie_shows.where("date(timing) = ?", date).select{ |m| audi_ids.include? m.audi_id}
          #logger.info(shows.inspect)
          listing[theatre.location.to_sym] = shows if shows.any?
        end
      end
    return listing
  end

  def self.movie_listing_by_theatre (theatre_location, movie_date)
    movie_date = movie_date.split(",")
    date = Date.parse(movie_date[1])
    theatre = Theatre.find_by_location(theatre_location)
    listing = Hash.new(Array.new)
    movies = theatre.movies
    audis = theatre.audis
    movies.each do |movie|
        audis.each do |audi|
          shows = audi.movie_shows.where("date(timing) = ? and movie_id = ?", date, movie.id)
          listing[movie.name.to_sym] += shows if shows.any?
        end
    end
    return listing
  end
end