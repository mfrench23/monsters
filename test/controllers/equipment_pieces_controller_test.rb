require 'test_helper'

class EquipmentPiecesControllerTest < ActionController::TestCase
  setup do
    @equipment_type = FactoryGirl.create(:equipment_type)
    @equipment_package = FactoryGirl.create(:equipment_package)
    @equipment_piece = FactoryGirl.create(:equipment_piece, :equipment_type => @equipment_type, :owner => @equipment_package)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should show equipment_piece" do
    get :show, id: @equipment_piece
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipment_piece
    assert_response :success
  end

  test "should update equipment_piece" do
    patch :update, id: @equipment_piece, equipment_piece: { equipment_type_id: @equipment_piece.equipment_type_id }
    assert_redirected_to @equipment_piece
  end

  test "should destroy equipment_piece" do
    assert_difference('EquipmentPiece.count', -1) do
      delete :destroy, id: @equipment_piece
    end

    assert_redirected_to equipment_pieces_path
  end
end
