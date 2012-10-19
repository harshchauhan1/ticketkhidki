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
    # movie_shows = theatres.movie_shows
    timing = []
    shows = []
    listing = Hash.new(Array.new)
      # theatres.each do |t|
      #   movie_shows.each do |m|
      #     if t.id == m.audi.theatre.id
      #       timing.push(m.timing.strftime("%H" ":" "%M"))
      #       shows << m
      #     end
      #   end
      #   listing[t.location] = timing
      #   timing = []
      # end

      theatres.each do |theatre|
        if theatre.movies.where('id = ?', movie.id).any?
          audi_ids = theatre.audis.collect(&:id)
          shows = theatre.movies.where('id = ?', movie.id)[0].movie_shows.select{ |m| audi_ids.include? m.audi_id }
          listing[theatre.location.to_sym] = shows
          Rails.logger.info shows
        end
      end
    return listing
  end
end