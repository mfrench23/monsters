require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  setup do
    @location = Location.find_by(name: "skull")
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr", 15 # 15 locations in seed data
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location" do
    name = "Cockles of the heart"
    assert_difference('Location.count') do
      post :create, location: { name: name }
    end

    assert_response :found
    location = Location.where(:name => name ).order("created_at desc").first
    assert_not_nil location
    assert_redirected_to location
  end

  test "should fail to create location" do
    assert_no_difference('Location.count') do
      post :create, location: { name: nil }
    end

    assert_response 200
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location
    assert_response :success
  end

  test "should update location" do
    patch :update, id: @location, location: { name: @location.name }
    assert_redirected_to @location
  end

  test "should fail to update location" do
    patch :update, id: @location, location: { name: nil }
    assert_response 200
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_redirected_to locations_path
  end
end
