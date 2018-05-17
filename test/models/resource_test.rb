require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  setup do
    @books = create :resource, name: 'Free books'
    @videos = create :resource, name: 'Free videos'

    @books.tag_list.add('books')
    @books.save
  end

  test '.with_tags returns all resources when no arguments are passed' do
    assert_equal Resource.with_tags, [@books, @videos]
  end

  test '.with_tags returns only relevant tagged resources when tagged arguments are passed' do
    assert_equal Resource.with_tags('books'), [@books]
  end
end
