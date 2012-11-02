class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessible :is_admin, :as => :admin
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true
  validates :password, :presence => true
  validates :password, :length => {:within => 8..20}, :unless => proc { |user| user.password.blank? }
  #validates :password_confirmation, :presence => true, :unless => proc { |user| user.password.blank?  }
  validates :email, :format => { :with => /^([A-z])+(\.?\w+)*@[A-z]+(\.[A-z]{2,4}){1,2}/ }
  has_many :bookings
  has_one :wallet
  after_create :create_wallet
  
  has_secure_password

  def assign(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end

  def self.user_arr
    all.collect{|user| user.name}
  end

  def create_wallet
    u = User.last
    u.wallet = Wallet.create(:money => 10000)
  end


end