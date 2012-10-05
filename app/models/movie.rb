class Movie < ActiveRecord::Base
  attr_accessible :genre, :name, :release_date
  has_many :shows
end
