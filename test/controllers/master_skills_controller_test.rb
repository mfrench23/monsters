require 'test_helper'

class MasterSkillsControllerTest < ActionController::TestCase
  setup do
    @master_skill = FactoryGirl.create(:master_skill)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:master_skills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create master_skill" do
    assert_difference('MasterSkill.count') do
      post :create, master_skill: { baseStat: @master_skill.baseStat, name: @master_skill.name, notes: @master_skill.notes }
    end

    assert_redirected_to master_skill_path(assigns(:master_skill))
  end

  test "should fail to create master_skill" do
    assert_no_difference('MasterSkill.count') do
      post :create, master_skill: { baseStat: @master_skill.baseStat, name: nil, notes: @master_skill.notes }
    end

    assert_response 200
  end
  
  test "should show master_skill" do
    get :show, id: @master_skill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @master_skill
    assert_response :success
  end

  test "should update master_skill" do
    patch :update, id: @master_skill, master_skill: { baseStat: @master_skill.baseStat, name: @master_skill.name, notes: @master_skill.notes }
    assert_redirected_to master_skill_path(assigns(:master_skill))
  end

  test "should fail to update master_skill" do
    patch :update, id: @master_skill, master_skill: { baseStat: nil }
    assert_response 200
  end

  test "should destroy master_skill" do
    assert_difference('MasterSkill.count', -1) do
      delete :destroy, id: @master_skill
    end

    assert_redirected_to master_skills_path
  end
end
