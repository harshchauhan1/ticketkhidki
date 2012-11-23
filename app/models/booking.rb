class Booking < ActiveRecord::Base
  attr_accessible :seat_num, :movie_show_id, :sub_total, :user_id, :t_id
  belongs_to :user
  belongs_to :movie_show
  validates :movie_show_id, :presence  => true
  validates :user_id, :presence => true
  validates :movie_show_id, :uniqueness => {:scope => :seat_num}
  after_create :send_notification
  before_create :check_for_balance, :check_for_old_show

  def check_for_balance
    if user.wallet.money < sub_total
      errors.add("insufficient balance")
    end
  end

  def check_for_old_show
    if movie_show.timing < DateTime.now
      error.add("cant book for past shows")
    end
  end
  
  def self.book_seats(movie_show, seats, total_price, wallet, balance, user_id, price_per_seat)
      logger.info(price_per_seat)
    transaction_id = (1..8).map{ rand(36).to_s(36) }.join
    admin_wallet = User.where('is_admin = ?', true).first.wallet
    seats.each do |seat_num|
      booking = Booking.create(:user_id => user_id, :movie_show_id => movie_show.id, :sub_total => price_per_seat[seat_num], :seat_num => seat_num, :t_id => transaction_id)
      if booking
        wallet.update_attribute(:money, balance)
        admin_wallet.update_attribute(:money, (admin_wallet.money + total_price))     
      else
        return false
      end
    end
    return true, transaction_id
  end

  def self.theatre_revenue_report(theatre, date)
    @audi_report = {}
    total_revenue = 0
    audi_ids = theatre.audis.pluck(:id)
    movie_shows = MovieShow.where('date(timing) =? and audi_id in (?)', date, audi_ids )
    movie_shows.each do |show|
      revenue_per_show  = show.bookings.select('count(*) booking_count, sum(sub_total) as total')
      @audi_report[show.audi_id] ||= {}
      @audi_report[show.audi_id][show.id] ||= {}
      @audi_report[show.audi_id][show.id][:movie_revenue] ||= 0
      @audi_report[show.audi_id][show.id][:movie_revenue] += revenue_per_show[0].total.to_f
      @audi_report[show.audi_id][show.id][:no_of_bookings] =  revenue_per_show[0].booking_count
      total_revenue += revenue_per_show[0].total.to_f
    end
    @audi_report[:total_revenue] = total_revenue
    return @audi_report
  end

  def send_notification 
    Emailer.contact(self.user.email, "Your booking details", "#{self.id}").deliver
  end
end