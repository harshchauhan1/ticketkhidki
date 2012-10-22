class Emailer < ActionMailer::Base
  default from: "admin@ticketkhidki.com"
   def contact(recipient, subject, message, sent_at = Time.now)
      @subject = subject
      @message = message
      @recipients = recipient
      @from = 'no-reply@yourdomain.com'
      mail(:to => @recipients, :subject => @subject)
   end
end
