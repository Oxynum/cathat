class User < ActiveRecord::Base
  GENDERS = ["male", "female", "transgender", "unknown", "animal", "vegetable", "alien"].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :pseudo, :birth_date

  def connect!
    self.update_attribute :connected, true
  end

  def disconnect!
    self.update_attribute :connected, false
  end

  def self.connected
    where connected: true
  end
end