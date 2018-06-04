require 'test_helper'

class JobTest < ActiveSupport::TestCase

  setup do
    @job = create :job
  end

  test "should be valid" do
    assert @job.valid?
  end

  test ".with_tags returns job with tag" do
    @job.tag_list.add('front-end')
    @job.save!
    assert_equal Job.with_tags('front-end'), [@job]
  end
end

