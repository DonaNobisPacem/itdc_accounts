class ApplicationMailer < ActionMailer::Base
  default from: 'info.ovpd@up.edu.ph'
  layout 'mailer'
  
  def hello_world
    mail(to: 'johnthomasraphael@yahoo.com', subject: 'Mailer works!')
  end

  def welcome_email(user)
    @user = user
    @url  = '45.58.38.202'
    mail(to: @user.email, subject: 'Welcome to the Accounts Management System')
  end
end
