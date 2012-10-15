class Audi < ActiveRecord::Base
  attr_accessible :capacity, :theatre_id
  belongs_to :theatre
  has_many :seats
  has_many :movie_shows

end
