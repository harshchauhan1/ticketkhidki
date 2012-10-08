class Theatre < ActiveRecord::Base
  attr_accessible :location, :no_of_audis
  has_many :audis
end
