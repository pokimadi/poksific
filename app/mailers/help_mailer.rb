class HelpMailer < ActionMailer::Base
  default from: "examfoo@gmail.com"
  
  def contact_email(message)
    @message = message
    mail(:to => "examfoo@gmail.com" ,:subject => "Notification: #{message.subject}")
  end
end
