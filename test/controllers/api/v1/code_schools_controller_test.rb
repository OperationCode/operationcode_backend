require 'test_helper'

class Api::V1::CodeSchoolsControllerTest < ActionDispatch::IntegrationTest  
  test "Schools cannot save without valid fields" do 
    school = CodeSchool.create name: "Only Name Included"
    school.save
    assert_equal true, school.errors.full_messages.include?("Full time can't be blank")
  end
  
  test ":index will find schools" do 
    get api_v1_code_schools_path
    assert_response :success
  end
  
  test ":show will not work for a invalid record" do
    get api_v1_code_school_path(1)
    assert_response :missing
  end
end

