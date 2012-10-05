class Booking < ActiveRecord::Base
  attr_accessible :seat_num, :show_id, :sub_total, :user_id
  belongs_to :user
  belongs_to :show
end
