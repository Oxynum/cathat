class User < ActiveRecord::Base
  GENDERS = ["male", "female", "transgender", "unknown", "animal", "vegetable", "alien"].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # validates_presence_of :pseudo, :birth_date
  has_many :subscriptions
  has_many :channels, through: :subscriptions

  before_create :generate_token


  def email_md5
    Digest::MD5.hexdigest(email)
  end

  def connect!
    self.update_attribute :connected, true
  end

  def disconnect!
    self.update_attribute :connected, false
  end

  def self.connected
    where connected: true
  end

  def change_token
    generate_token
    save
  end

  def users_in_area
    User.where('( 6371 * acos( cos( radians(?) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(?) ) + sin( radians(?) ) * sin( radians( latitude ) ) ) ) < message_zone', 
    latitude, longitude, latitude)
  end

  def self.find_or_create_from_auth_hash auth_hash
    send((auth_hash['provider'] + "_auth").to_sym, auth_hash)
  end

  protected

  def self.facebook_auth auth_hash
    @user = find_provider_user auth_hash
    return @user if @user
    generated_password = Devise.friendly_token.first(8)
    @user = User.create(
      email:                  auth_hash['info']['email'],
      password:               generated_password,
      password_confirmation:  generated_password,
      pseudo:                 auth_hash['info']['nickname'],
      first_name:             auth_hash['info']['first_name'],
      last_name:              auth_hash['info']['last_name'],
      gender:                 auth_hash['extra']['raw_info']['gender'],
      provider:               auth_hash['provider'],
      uid:                    auth_hash['uid'],
      provider_token:         auth_hash['credentials']['token']
    )
  end

  def self.twitter_auth auth_hash
    @user = find_provider_user auth_hash
    return @user if @user
    generated_password = Devise.friendly_token.first(8)
    @user = User.create(
      password:               generated_password,
      password_confirmation:  generated_password,
      pseudo:                 auth_hash['info']['nickname'],
      first_name:             auth_hash['info']['name'].split[0],
      last_name:              auth_hash['info']['name'].split[1..-1].join,
      provider:               auth_hash['provider'],
      uid:                    auth_hash['uid'],
      provider_token:         auth_hash['credentials']['token']
    )
  end

  def self.google_oauth2_auth auth_hash
    @user = find_provider_user auth_hash
    return @user if @user
    generated_password = Devise.friendly_token.first(8)
    @user = User.create(
      email:                  auth_hash['info']['email'],
      password:               generated_password,
      password_confirmation:  generated_password,
      first_name:             auth_hash['info']['first_name'],
      last_name:              auth_hash['info']['last_name'],
      gender:                 auth_hash['extra']['raw_info']['gender'],
      birth_date:             auth_hash['extra']['raw_info']['birthday'] && Time.parse(auth_hash['extra']['raw_info']['birthday']),
      provider:               auth_hash['provider'],
      uid:                    auth_hash['uid'],
      provider_token:         auth_hash['credentials']['token']
    )
  end

  def self.find_provider_user auth_hash
    where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first
  end

  def generate_token
    self.authentication_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(authentication_token: random_token)
    end
  end

  def email_required?
    true unless provider == "twitter"
  end
end