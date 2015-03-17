require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  setup do
    @location = FactoryGirl.create(:location)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, location: { name: @location.name }
    end

    assert_redirected_to location_path(assigns(:location))
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
    assert_redirected_to location_path(assigns(:location))
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
