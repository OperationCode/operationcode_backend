require 'test_helper'

class Api::V1::CodeSchoolsControllerTest < ActionDispatch::IntegrationTest  
  test "Schools cannot save without required fields" do 
    school = CodeSchool.create name: "Only Name Included"
    assert_equal false, school.valid?
  end
  
  test ":index endpoint returns a JSON list of all CodeSchools" do 
    school = create(:code_school)
    
    get api_v1_code_schools_path, as: :json
    assert_equal response.status, 200
  end
  
  test ":show will not work for a invalid record" do
    get api_v1_code_school_path(1)
    assert_response :missing
  end
  
  test ":update" do 
    school = build(:code_school)
    school.notes = "Updates this attribute"
    school.save
    assert_equal "Updates this attribute", school.notes
  end
  
  test ":destroy" do 
  end
end

