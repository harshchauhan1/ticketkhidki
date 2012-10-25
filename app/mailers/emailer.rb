class Emailer < ActionMailer::Base
  default from: "admin@ticketkhidki.com"
   def contact(recipient, subject, message)
      @subject = subject
      @message = Booking.find(message.to_i)
      @user = @message.user.name
      @movie = @message.movie_show.movie.name 
	  @location = @message.movie_show.audi.theatre.location
	  @timing = @message.movie_show.timing
	  @seats = @message.seat_num
	  @total =  @message.sub_total
      @recipients = recipient
      @from = 'no-reply@yourdomain.com'
      mail(:to => @recipients, :subject => @subject)
   end
end
