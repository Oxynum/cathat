class UserSerializer < ActiveModel::Serializer
  attributes :id, :pseudo, :email_md5
end
