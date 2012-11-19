class Movie < ActiveRecord::Base
  attr_accessible :genre, :name, :release_date, :image_url
  has_many :movie_shows, :dependent => :destroy
  has_many :bookings, :through => :movie_shows
  has_and_belongs_to_many :theatres
  def self.movie_arr
    movie = []
  	movie  = all.collect{|movie| movie.name}
    movie.unshift("select movie")
  end
  def self.movie_listing_by_movie (movie_name, movie_date)
    movie_date = movie_date.split(",")
    date = Date.parse(movie_date[1])
  	movie = Movie.find_by_name(movie_name)
    theatres = Theatre.scoped
    shows = []
    logger.info(date)
    listing = Hash.new(Array.new)
      theatres.each do |theatre|
        if theatre.movies.where('id = ?', movie.id).any?
          audi_ids = theatre.audis.collect(&:id)
          shows = theatre.movies.where('id = ?', movie.id)[0].movie_shows.where("date(timing) = ?", date).select{ |m| audi_ids.include? m.audi_id}
          listing[theatre.location.to_sym] = shows
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
          shows = audi.movie_shows.where("date(timing) = ?", date)
          listing[movie.name.to_sym] = shows
        end
    end
    return listing
  end
end