class Message < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	belongs_to :channel
	has_many :subscriptions
	has_many :subscribers, through: :subscriptions
	default_scope {order('created_at DESC')}

	def self.message_in_area latitude, longitude, area_in_km
  		where('( 6371 * acos( cos( radians(?) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(?) ) + sin( radians(?) ) * sin( radians( latitude ) ) ) ) < ?', 
  		latitude, longitude, latitude, area_in_km)
	end

	def self.main_information
		includes(:author, :channel)
	end
end
