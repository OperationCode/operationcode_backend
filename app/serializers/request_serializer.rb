class RequestSerializer < ActiveModel::Serializer
  attributes :details,
             :language,
             :service_id

  belongs_to :user
  belongs_to :requested_mentor
  belongs_to :assigned_mentor
end
