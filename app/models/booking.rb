class Booking < ActiveRecord::Base
  attr_accessible :seat_num, :movie_show_id, :sub_total, :user_id
  belongs_to :user
  belongs_to :movie_show
  validates :movie_show_id, :presence  => true
  validates :user_id, :presence => true
  validates :movie_show_id, :uniqueness => {:scope => :seat_num}
  after_create :send_notification
  before_create :check_for_balance, :check_for_old_show

  def check_for_balance
    if (user.wallet.money < sub_total)
      return false
    end
  end

  def check_for_old_show
    if (movieshow.timing < DateTime.now)
      return false
    end
  end
  
  def self.book_seats(movie_show, seats, total_price, wallet, balance, user_id)
    if seats.any? && balance >= 0
      #wallet.update_attribute(:money, balance)
      admin_wallet = User.where('is_admin = ?', true).first.wallet
      admin_wallet.update_attribute(:money, (admin_wallet.money + total_price))
      booking = Booking.new
      booking.user_id = user_id
      booking.movie_show_id = movie_show.id
      booking.sub_total = total_price
      booking.seat_num = seats.join(',')
      if booking.save
        movie_show.seats.where("seat_no in (#{seats.join(',')})").update_all(:status => true)
        return true, booking
      else
        return false
      end
    else
     return false
    end
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