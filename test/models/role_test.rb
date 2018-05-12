require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test 'role requires a title' do
    role = build(:role, title: '')

    refute role.valid?
  end

  test 'title must be unique' do
    standard_role = create :role, title: 'standard'
    assert standard_role.valid?

    duplicate_role = build :role, title: 'standard'
    duplicate_role.save

    refute duplicate_role.valid?
    assert duplicate_role.errors.full_messages.include? 'Title has already been taken'
  end
end
