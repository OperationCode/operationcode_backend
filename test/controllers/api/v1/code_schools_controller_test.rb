require 'test_helper'

class Api::V1::CodeSchoolsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @school = create(:code_school)
  end
  test "Schools cannot save without required fields" do 
    school = CodeSchool.create name: "Only Name Included"
    assert_equal false, school.valid?
  end
  
  test ":index endpoint returns a JSON list of all CodeSchools" do 
    get api_v1_code_schools_path, as: :json    
    assert_equal JSON.parse(response.body)[0]["name"], "CoderSchool"
  end
  
  test ":show will not work for a invalid record" do
    school_count = CodeSchool.count + 1
    get api_v1_code_school_path(school_count), as: :json
    assert_response :missing
  end
  
  test ":update" do
    put api_v1_code_school_url(@school), params: {name: "CoddderrrrSchool"}, as: :json
    assert_equal response.status, 200
    assert_equal JSON.parse(response.body)["name"], "CoddderrrrSchool"
  end
  
  test ":destroy" do
    id = @school.id
    delete api_v1_code_school_url(@school)
    
    assert_equal response.status, 200
    
    get api_v1_code_school_path(id), as: :json
    assert_response :missing
  end
end

