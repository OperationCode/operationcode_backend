class LocationSerializer < ActiveModel::Serializer
  attributes :va_accepted, :address1, :address2, :city, :state, :zip
end
