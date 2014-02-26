class User < ActiveRecord::Base
  GENDERS = ["male", "female", "transgender", "unknown", "animal", "vegetable", "alien"].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]
  validates_presence_of :pseudo, :birth_date
  has_and_belongs_to_many :channels

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