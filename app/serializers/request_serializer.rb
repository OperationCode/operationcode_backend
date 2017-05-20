class RequestSerializer < ActiveModel::Serializer
  attributes :id,
             :details,
             :language,
             :created_at

  belongs_to :user
  belongs_to :requested_mentor
  belongs_to :assigned_mentor
  belongs_to :service
end
