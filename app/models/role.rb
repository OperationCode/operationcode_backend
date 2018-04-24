class Role < ApplicationRecord
  SUPER_ADMIN = 'super_admin'
  ADMIN = 'admin'
  BOARD = 'board_member'

  has_many :users
  has_many :admin_users

  validates :title, presence: true, uniqueness: true

  def board_accessible?
    [BOARD, ADMIN, SUPER_ADMIN].include? title
  end

  def admin_accessible?
    [ADMIN, SUPER_ADMIN].include? title
  end

  def super_admin?
    title == SUPER_ADMIN
  end

  def admin?
    title == ADMIN
  end

  def board?
    title == BOARD
  end
end
