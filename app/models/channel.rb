class Channel < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
	has_and_belongs_to_many :subscribers, class_name: "User"
	has_many :messages

end
