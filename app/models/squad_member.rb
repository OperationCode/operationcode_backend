class SquadMember < ApplicationRecord
  belongs_to :user
  belongs_to :squad
end
