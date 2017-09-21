require 'test_helper'

class CodeSchoolTest < ActiveSupport::TestCase
  def setup 
  	@school = CodeSchool.create 
    name: "CoderSchool", 
    url: "http://www.CoderSchool.vn", 
    logo: "http://www.google.com",
    full_time: false,
    hardware_included: false,
    has_online: true,
    online_only: false,
    notes: "Amazingly cool place!"
  end
end
