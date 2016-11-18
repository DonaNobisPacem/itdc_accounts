class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'http://ams.up-ovpd.ph'
    mail(to: @user.email, subject: 'Welcome to the Accounts Management System')
  end
end
