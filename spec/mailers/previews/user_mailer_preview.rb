# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def sample_hello_world_preview
    UserMailer.hello_world
  end

  def sample_welcome_email_preview
    UserMailer.welcome_email(User.first)
  end
end
