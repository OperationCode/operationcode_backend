class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role

  before_save :set_role

  private

  def set_role
    if role_id.blank?
      self.role_id = Role.find_by(title: Role::BOARD)&.id
    end
  end
end
