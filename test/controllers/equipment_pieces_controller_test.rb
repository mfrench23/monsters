require 'test_helper'

class EquipmentPiecesControllerTest < ActionController::TestCase
  setup do
    @equipment_type = FactoryGirl.create(:equipment_type)
    @equipment_package = FactoryGirl.create(:equipment_package)
    @equipment_piece = FactoryGirl.create(:equipment_piece, :equipment_type => @equipment_type, :quantity => 1, :owner => @equipment_package)
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

  test "should fail to update" do
    patch :update, id: @equipment_piece, equipment_piece: { equipment_type_id: nil }
    assert_response 200
  end

  test "should destroy equipment_piece" do
    @request.env['HTTP_REFERER'] = equipment_pieces_path
    assert_difference('EquipmentPiece.count', -1) do
      delete :destroy, id: @equipment_piece
    end

    assert_redirected_to equipment_pieces_path
  end

  test "can get modifier choices appropriate to an equipment_piece" do
    get :modifiers_for_piece, {:equipment_piece_id => @equipment_piece.id, :equipment_type_id => @equipment_type.id, :title => "true" }
    assert_response :success
    assert_select "span", { :text => "Equipment Piece Modifiers" }
    assert_select "span", { :text => "none applicable" }
  end
end
