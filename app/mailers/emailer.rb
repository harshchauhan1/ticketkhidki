class Emailer < ActionMailer::Base
  default from: "admin@ticketkhidki.com"
   def contact(recipient, subject, message)
      @details = message
      @from = 'no-reply@yourdomain.com'
      mail(:to => recipient, :subject => subject)
   end

   def user_registered (recipient, subject, message)
      curr_user = User.find(message.to_i)
      @subject = subject
      @email = curr_user.email
      @name = curr_user.name
      @recipients = recipient
      @money = curr_user.wallet.money
      @from = 'no-reply@yourdomain.com'
      mail(:to => @recipients, :subject => @subject)
   end
end
