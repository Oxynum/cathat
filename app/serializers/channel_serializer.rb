class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :title, :latitude, :longitude, :creator_id, :created_at, :updated_at, :image_urls
  has_many :messages
  has_many :subscribers

  def image_urls
    result = {}
    [nil, :large, :medium, :small, :thumb].each do |version|
      result[version||:normal] =  object.image.url(version)
    end
    result
  end
end