class Movie < ActiveRecord::Base
  attr_accessible :genre, :name, :release_date, :image_url
  has_many :movie_shows
  has_and_belongs_to_many :theatres
  def self.movie_arr
    movie = []
  	movie  = all.collect{|movie| movie.name}
    movie.unshift("select movie")
  end
  def self.movie_details (movie_name, movie_date, theatre)
    logger.info(movie_name)
    logger.info(theatre)
    
    movie_date = movie_date.split(",")
    date = Date.parse(movie_date[1])
  	movie = Movie.find_by_name(movie_name)
    theatres = Theatre.all
    shows = []
    logger.info(date)
    listing = Hash.new(Array.new)
      theatres.each do |theatre|
        if theatre.movies.where('id = ?', movie.id).any?
          audi_ids = theatre.audis.collect(&:id)
          shows = theatre.movies.where('id = ?', movie.id)[0].movie_shows.select{ |m| audi_ids.include? m.audi_id}
          shows1 = shows.select{|s| s.timing.to_date == date}
          listing[theatre.location.to_sym] = shows1
        end
      end
    return listing
  end
end