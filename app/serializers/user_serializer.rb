class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :zip
end
