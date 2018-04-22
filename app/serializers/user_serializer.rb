class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :zip, :first_name, :last_name,
             :mentor, :verified
  attributes :role

  def role
    object.role&.title
  end
end
