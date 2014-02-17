class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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