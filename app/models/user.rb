class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation#, :terms_of_service
  attr_accessible :is_admin, :as => :admin
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true 
  #validates :password, :presence => true
  #validates :password, :confirmation => true, :if => proc { |user| user.password.length > 8  }
  #validates :terms_of_service, :acceptance => true
  validates :password, :length => {:within => 8..20}, :unless => proc { |user| user.password.blank? }
  #validates :password_confirmation, :presence => true, :unless => proc { |user| user.password.blank? || user.password.length < 8  }
  validates :email, :format => { :with => /^([A-z])+(\.?\w+)*@[A-z]+(\.[A-z]{2,4}){1,2}/ }
  has_many :bookings
  has_one :wallet, :dependent => :destroy
  after_create :create_wallet#, :send_notification
  
  has_secure_password

  def assign(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end

  def self.user_arr
    user = []
    user = all.collect{|user| user.name}
    admin = User.where(:is_admin => true)[0].name
    user.unshift("select user")
    user.delete(admin)
    return user
  end

  def create_wallet
    self.wallet = Wallet.create(:money => 10000)
  end

  # def send_notification
  #   Emailer.user_registered(@user.email, "welcome to ticketkhidki", @user.id).deliver
  #   return if request.xhr?
  # end

end