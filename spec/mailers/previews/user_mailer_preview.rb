# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def sample_hello_world_preview
    UserMailer.hello_world
  end

  def sample_welcome_email_preview
    UserMailer.welcome_email(User.first)
  end

  def sample_account_update_preview
    @user = FactoryGirl.create(:user, first_name: "Regular")
    @admin = FactoryGirl.create(:user)

    @account_type = FactoryGirl.create(:account_type)
    @account = FactoryGirl.create(:account, user: @user, balance: 1000.00, account_type: @account_type.id)

    UserMailer.account_update(@user, @admin, @account)
  end
end
