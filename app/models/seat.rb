class Seat < ActiveRecord::Base
  attr_accessible :audi_id, :price, :seat_no, :seat_type, :status
  belongs_to :audi
end
