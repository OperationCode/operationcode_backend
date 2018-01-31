require 'test_helper'

class Api::V1::CodeSchoolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)
    @school = create(:code_school)
    @school.name = "CoderSchool"
    @school.save
    @location = create(
      :location,
      code_school: @school,
      address1: "2405 Nugget Lane"
    )
  end

  test ":validates CodeSchool's required fields" do
    params = {
      code_school: {
        name: "CoderSchool"
      }
    }
    post api_v1_code_schools_url,
      params: params,
      headers: @headers,
      as: :json

    errors = JSON.parse(response.body)["errors"]
    assert errors.include? "Url can't be blank"
  end

  test ":index endpoint returns a JSON list of all CodeSchools" do
    get api_v1_code_schools_path, as: :json

    body = JSON.parse(response.body)[0]
    locations = body["locations"]
    assert_equal body["name"], "CoderSchool"
    assert_not_nil locations
    assert_not_nil locations.first["address1"]
    assert_equal locations.first["address1"], "2405 Nugget Lane"
  end

  test ":create endpoint creates a CodeSchool successfully" do
    post api_v1_code_schools_path(@school),
      params: { code_school: @school },
      headers: @headers,
      as: :json
    assert_response :ok
  end

  test ":create endpoint responds unauthorized for unauthenticated user" do
    post api_v1_code_schools_path(@school),
      params: { code_school: @school },
      as: :json
    assert_response :unauthorized
  end

  test ":show will not work for a invalid record" do
    get api_v1_code_school_path(99999999), as: :json
    assert_response :missing
  end

  test ":show works for a valid record"do
    get api_v1_code_school_path(@school), as: :json
    assert_response :ok
  end

  test ":update endpoint updates an existing CodeSchool" do
    put api_v1_code_school_path(@school),
      params: { name: "CoddderrrrSchool" },
      headers: @headers,
      as: :json

    name = JSON.parse(response.body)["name"]
    assert_equal response.status, 200
    assert_equal name, "CoddderrrrSchool"
  end

  test ":update endpoint responds unauthorized for unauthenticated user" do
    put api_v1_code_school_path(@school),
      params: { name: "CoddderrrrSchool" },
      as: :json
    assert_response :unauthorized
  end

  test ":destroy endpoint destroys an existing CodeSchool" do
    id = @school.id

    delete api_v1_code_school_path(@school), headers: @headers
    assert_equal response.status, 200

    get api_v1_code_school_path(id), as: :json
    assert_response :missing
  end

  test ":destroy endpoint responds unauthorized for unauthenticated user" do
    delete api_v1_code_school_path(@school), as: :json
    assert_response :unauthorized
  end
end
