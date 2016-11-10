class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :accounts, dependent: :destroy
  accepts_nested_attributes_for :accounts, allow_destroy: true

  searchkick

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    if user.present?
      unless user.provider.present? || user.uid.present?
        # user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name   # assuming the user model has a name
        user.last_name = auth.info.last_name
        user.image = auth.info.image # assuming the user model has an image
      end
    end

    user

    # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #   user.email = auth.info.email
    #   user.password = Devise.friendly_token[0,20]
    #   user.first_name = auth.info.first_name   # assuming the user model has a name
    #   user.last_name = auth.info.last_name
    #   user.image = auth.info.image # assuming the user model has an image
    # end
  end

  def user_type
    admin ? "Admin" : "Regular"
  end

  def name
    last_name + ", " + first_name
  end
end
