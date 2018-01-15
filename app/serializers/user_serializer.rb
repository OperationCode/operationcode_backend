class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :zip, :first_name, :last_name,
             :slack_name, :mentor, :verified, :interests
end
