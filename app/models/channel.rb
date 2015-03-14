class Channel < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
	has_many :subscriptions
	has_many :subscribers, through: :subscriptions, source: :user
	has_many :messages
end
