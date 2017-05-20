class SquadSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :minimum, :maximum,
             :skill_level, :activities, :end_condition

  belongs_to :leader
  has_many :mentors
end
