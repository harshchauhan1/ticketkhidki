class Audi < ActiveRecord::Base
  attr_accessible :capacity, :theatre_id
  belongs_to :theatre_id
  has_many :seats
  has_many :shows
end
