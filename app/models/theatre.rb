class Theatre < ActiveRecord::Base
  attr_accessible :location, :no_of_audis
  has_many :audis
  has_and_belongs_to_many :movies


end
