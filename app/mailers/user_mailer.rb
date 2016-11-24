class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'http://ams.up-ovpd.ph'
    mail(to: @user.email, subject: 'Welcome to the Accounts Management System')
  end

  def account_update(user, admin, account)
    @user = user
    @user_name = @user.first_name.present? ? @user.first_name : @user.email
    @admin = admin
    @admin_name = @admin.first_name.present? ? @admin.first_name : @admin.email

    @account = account
    @url  = 'http://ams.up-ovpd.ph'
    
    mail(to: @user.email, subject: 'Your AMS account has been updated')
  end
end
