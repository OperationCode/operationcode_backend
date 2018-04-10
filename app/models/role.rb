class Role < ApplicationRecord
  SUPER_ADMIN = 'super_admin'.freeze
  ADMIN = 'admin'.freeze
  BOARD = 'board_member'.freeze

  has_many :users
  has_many :admin_users

  validates :title, presence: true, uniqueness: true

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
