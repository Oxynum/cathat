class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :latitude, :longitude, :created_at, :updated_at, :channel_id
  has_one :author
end
