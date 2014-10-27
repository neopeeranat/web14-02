class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook,:gplus,:twitter]
  has_many :directions, dependent: :destroy

  #Since Twitter not provide email info, we have to create dummy email for twitter login

  def self.from_omniauth(auth)
    if auth.provider != "twitter"
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        #user.image = auth.info.image # assuming the user model has an image
      end
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = "#{auth.uid}_email@twitter.com"
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        #user.image = auth.info.image # assuming the user model has an image
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data =  session["devise.gplus_data"] && session["devise.gplus_data"]["extra"]["raw_info"] || \
                 session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]|| \
                session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        if user.provider != "twitter"
          user.email = data["email"] if user.email.blank?
        else
          user.email = "#{auth.uid}_email@twitter.com" if user.email.blank?
        end
      end
    end
  end

end
