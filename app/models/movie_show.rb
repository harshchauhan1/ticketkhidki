class MovieShow < ActiveRecord::Base
  attr_accessible :audi_id, :movie_id, :timing
  belongs_to :movie
  belongs_to :audi
  
end