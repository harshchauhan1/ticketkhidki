class Audi < ActiveRecord::Base
  attr_accessible :capacity, :theatre_id
  belongs_to :theatre
  has_many :seats
  has_many :movie_shows,  :dependent => :destroy
  # after_create :store_session_id



  # def store_session_id
  # 	a = Audi.last
  # 	a.capacity = session[:id]
  # end
end
