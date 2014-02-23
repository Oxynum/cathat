class User < ActiveRecord::Base
  GENDERS = ["male", "female", "transgender", "unknown", "animal", "vegetable", "alien"].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]
  validates_presence_of :pseudo, :birth_date

  before_create :generate_token

  def connect!
    self.update_attribute :connected, true
  end

  def disconnect!
    self.update_attribute :connected, false
  end

  def self.connected
    where connected: true
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name 
      user.last_name = auth.info.last_name
      user.pseudo = auth.info.nickname
    end
  end

  def self.find_for_twitter_auth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.last_name = auth.info.name
      user.pseudo = auth.info.nickname
    end
  end

  def self.find_for_google_oauth2(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
    end
  end

  def change_token
    generate_token
    save
  end

  protected

  def generate_token
    self.authentication_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(authentication_token: random_token)
    end
  end
end