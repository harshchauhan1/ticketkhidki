class Theatre < ActiveRecord::Base
  attr_accessible :locatiom, :no_of_audis
  has_many :audis
end
