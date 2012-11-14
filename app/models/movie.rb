class Movie < ActiveRecord::Base
  attr_accessible :genre, :name, :release_date, :image_url
  has_many :movie_shows
  has_and_belongs_to_many :theatres
  def self.movie_arr
    movie = []
  	movie  = all.collect{|movie| movie.name}
    movie.unshift("select movie")
  end
  def self.movie_details (movie_name)
  	movie = Movie.find_by_name(movie_name)
    theatres = Theatre.all
    shows = []
    listing = Hash.new(Array.new)
      theatres.each do |theatre|
        if theatre.movies.where('id = ?', movie.id).any?
          audi_ids = theatre.audis.collect(&:id)
          shows = theatre.movies.where('id = ?', movie.id)[0].movie_shows.select{ |m| audi_ids.include? m.audi_id }
          listing[theatre.location.to_sym] = shows
        end
      end
    return listing
  end
end