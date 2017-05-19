class RequestSerializer < ActiveModel::Serializer
  attributes :user_id, :details, :language,
             :service_id, :requested_mentor_id
end
