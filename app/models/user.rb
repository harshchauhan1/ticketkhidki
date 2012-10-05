class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessible :is_admin, :as => :admin
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true
  validates :password_confirmation, :presence => true
  validates :email, :format => { :with => /^([A-z])+(\.?\w+)*@[A-z]+(\.[A-z]{2,4}){1,2}/ }
  has_many :bookings

  has_secure_password

  def assign(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end
end