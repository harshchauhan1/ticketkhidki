class Theatre < ActiveRecord::Base
  attr_accessible :location, :no_of_audis
  has_many :audis, :dependent => :destroy
  has_and_belongs_to_many :movies 


  def self.theatre_arr
  	theatre = []
    theatre = all.collect{|theatre| theatre.location}
    return theatre.unshift("select")
  end

  def self.add_new (no_of_audis, theatre_location)
  	i = 1
  	msg = String.new
  	num = no_of_audis.to_i
  	if theatre_location.strip.length > 0
	  	Theatre.create(:no_of_audis => num, :location => theatre_location)
	  	t = Theatre.last
	  	while i <= num
	  		t.audis.create(:capacity => 15)
	  		i = i + 1
	  	end
      msg = "#{theatre_location.capitalize} has been added succesfully to theatres"
	else
	  	msg = "something went wrong, make sure you enter correct info."
  	end
  	return msg
  end

  def self.remove_old (theatre_location)
    if theatre_location == "select"
      return "Please select a theatre!"
    end
  	theatre = Theatre.find_by_location(theatre_location)
  	theatre.delete
    if theatre
      return "Something went wrong, try deleting the theatre agian!"
    else
      return "theatre deleted successfully!"
    end
  end	
end
