class Theatre < ActiveRecord::Base
  attr_accessible :location, :no_of_audis
  has_and_belongs_to_many :movies 
  has_many :audis, :dependent => :destroy
  validates :location, :no_of_audis, :presence => true
  validates :location, :uniqueness => true
  validates :no_of_audis, :numericality => {:only_integer => true, :greater_than => 0, :less_than => 11, :allow_blank => true }
  before_validation :strip_space
  after_create :add_audis

  def strip_space
    self.location = location.strip
  end

  def add_audis
  	i = 1
	  while i <= no_of_audis
		 audis.create(:capacity => 15)
		 i = i + 1
	  end
  end
end
