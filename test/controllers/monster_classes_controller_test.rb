require 'test_helper'

class MonsterClassesControllerTest < ActionController::TestCase
  setup do
    @monster_class = MonsterClass.find_by(name: "Undead")
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

  test "should create monster_class" do
    name = "Animal, Stuffy"
    assert_difference('MonsterClass.count') do
      post :create, params: { monster_class: { name: name } }
    end

    assert_response :found
    monster_class = MonsterClass.where(:name => name ).order("created_at desc").first
    assert_not_nil monster_class
    assert_redirected_to monster_class
  end

  test "should fail to create monster_class" do
    assert_no_difference('MonsterClass.count') do
      post :create, params: { monster_class: { name: nil } }
    end

    assert_response 200
  end

  test "should show monster_class" do
    get :show, params: { id: @monster_class }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @monster_class }
    assert_response :success
  end

  test "should update monster_class" do
    patch :update, params: { id: @monster_class, monster_class: { name: @monster_class.name + " Part 2" } }
    assert_redirected_to @monster_class
  end

  test "should fail to update monster_class" do
    patch :update, params: { id: @monster_class, monster_class: { name: nil } }
    assert_response 200
  end

  test "should destroy monster_class" do
    @request.env['HTTP_REFERER'] = monster_classes_path
    assert_difference('MonsterClass.count', -1) do
      delete :destroy, params: { id: @monster_class }
    end

    assert_redirected_to monster_classes_path
  end
end
