require 'test_helper'

class EquipmentPackagesControllerTest < ActionController::TestCase
  setup do
    @equipment_package = FactoryGirl.create(:equipment_package)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should show equipment_package" do
    get :show, id: @equipment_package
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipment_package
    assert_response :success
  end

  test "should update equipment_package" do
    patch :update, id: @equipment_package, equipment_package: { name: @equipment_package.name + "2", notes: @equipment_package.notes.to_s + "\nJust adding some notes here.\n" }
    assert_redirected_to @equipment_package
  end

  test "should destroy equipment_package" do
    @request.env['HTTP_REFERER'] = equipment_packages_path
    assert_difference('EquipmentPackage.count', -1) do
      delete :destroy, id: @equipment_package
    end

    assert_redirected_to equipment_packages_path
  end
end
