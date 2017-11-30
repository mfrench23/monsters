require 'test_helper'

class MasterSkillsControllerTest < ActionController::TestCase
  setup do
    @master_skill = MasterSkill.find_by(name: "Stealth")
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create master_skill" do
    name = "A Skill In Being An Unlikely Skill Name"
    assert_difference('MasterSkill.count') do
      post :create, params: { master_skill: { characteristic_id: @master_skill.characteristic_id, name: name, notes: @master_skill.notes } }
    end

    assert_response :found
    master_skill = MasterSkill.where(:name => name ).order("created_at desc").first
    assert_not_nil master_skill
    assert_redirected_to master_skill
  end

  test "should fail to create master_skill" do
    assert_no_difference('MasterSkill.count') do
      post :create, params: { master_skill: { characteristic_id: @master_skill.characteristic_id, name: nil, notes: @master_skill.notes } }
    end

    assert_response 200
  end

  test "should show master_skill" do
    get :show, params: { id: @master_skill }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @master_skill }
    assert_response :success
  end

  test "should update master_skill" do
    patch :update, params: { id: @master_skill, master_skill: { characteristic_id: @master_skill.characteristic_id, name: @master_skill.name, notes: @master_skill.notes } }
    assert_redirected_to @master_skill
  end

  test "should fail to update master_skill" do
    patch :update, params: { id: @master_skill, master_skill: { characteristic_id: nil } }
    assert_response 200
  end

  test "should destroy master_skill" do
    @request.env['HTTP_REFERER'] = master_skills_path
    assert_difference('MasterSkill.count', -1) do
      delete :destroy, params: { id: @master_skill }
    end

    assert_redirected_to master_skills_path
  end
end
