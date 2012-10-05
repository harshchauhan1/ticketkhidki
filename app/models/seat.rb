class Seat < ActiveRecord::Base
  attr_accessible :audi_id, :price, :seat_no, :type
  belongs_to :audi
end
