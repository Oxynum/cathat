class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :title, :latitude, :longitude, :creator_id, :created_at, :updated_at
  has_many :messages
  has_many :subscribers
end