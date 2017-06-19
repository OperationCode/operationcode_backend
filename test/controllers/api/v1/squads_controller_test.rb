require 'test_helper'

class Api::V1::SquadsControllerTest < ActionDispatch::IntegrationTest

  test "users can see all squads" do
    skip
    user = create(:user)
    headers = authorization_headers(user)
    create_list(:squad, 2)

    get api_v1_squads_url, headers: headers, as: :json
    assert_equal 2, response.parsed_body.count
  end

  test "mentors can create new squads" do
    user = create(:mentor)
    headers = authorization_headers(user)
    mentor1 = create(:mentor)
    params = {
      squad: {
        name: Faker::Lorem.word,
        description: Faker::Lorem.paragraph,
        leader_id: user.id,
        minimum: 1,
        maximum: 5,
        skill_level: 'beginner',
        activities: Faker::Lorem.sentence,
        end_condition: Faker::Lorem.sentence,
        mentor_ids: [mentor1.id]
      }
    }

    post api_v1_squads_url, headers: headers, params: params, as: :json
    squad = response.parsed_body.symbolize_keys

    refute_nil squad[:id]
    assert_equal params[:squad][:name], squad[:name]
    assert_equal params[:squad][:description], squad[:description]
    assert_equal params[:squad][:minimum], squad[:minimum]
    assert_equal params[:squad][:maximum], squad[:maximum]
    assert_equal params[:squad][:skill_level], squad[:skill_level]
    assert_equal params[:squad][:activities], squad[:activities]
    assert_equal params[:squad][:end_condition], squad[:end_condition]
    assert_equal mentor1.id, squad[:mentors].first['id']
  end

  test 'users can show a squad' do
    user = create(:user)
    headers = authorization_headers(user)
    squad = create(:squad)

    get api_v1_squad_url(squad), headers: headers, as: :json
    squad_json = response.parsed_body.symbolize_keys
    assert_equal squad.id, squad_json[:id]
  end

  test 'users can join a squad' do
    user = create(:user)
    headers = authorization_headers(user)
    squad = create(:squad)

    post join_api_v1_squad_url(squad), headers: headers, as: :json
    squad_json = response.parsed_body.symbolize_keys
    assert_equal user.id, squad_json[:members].first['id']
  end

end
