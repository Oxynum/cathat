class Channel < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
	has_many :messages

end
