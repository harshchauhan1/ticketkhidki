class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true 
  validates :password, :length => {:within => 8..20}, :unless => proc { |user| user.password.blank? }
  validates :email, :format => { :with => /^([A-z])+(\.?\w+)*@[A-z]+(\.[A-z]{2,4}){1,2}/ }
  has_many :bookings
  has_one :wallet, :dependent => :destroy
  after_create :create_wallet, :send_notification
  
  has_secure_password


  # def self.user_arr
  #   user = User.where(:is_admin => false).collect{|u| u.name}
  #   return user
  # end

  def create_wallet
    self.wallet = Wallet.create(:money => 10000)
  end

  def send_notification
    Emailer.user_registered(self.email, "welcome to ticketkhidki", self.id).deliver
  end

end