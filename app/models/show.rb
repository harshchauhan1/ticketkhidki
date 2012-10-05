class Show < ActiveRecord::Base
  attr_accessible :audi_id, :movie_id, :timing
  belongs_to :audi
  belongs_to :movie
  has_many :bookings
end
