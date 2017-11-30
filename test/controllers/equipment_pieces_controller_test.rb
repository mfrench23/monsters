require 'test_helper'

class EquipmentPiecesControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    eq_category = EquipmentCategory.new(:name => "Knickknacks", :campaign => @campaign)
    eq_category.save!
    @equipment_type = EquipmentType.new(:name => "Rather Narrow Sword", :base_cost_cents => 1000, 
                                        :base_weight => 9.99, :random_weight => 1, :campaign => @campaign,
                                        :equipment_category => eq_category)
    @equipment_type.save!
    @equipment_piece = FactoryBot.create(:equipment_piece, :equipment_type => @equipment_type, :quantity => 1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should show equipment_piece" do
    get :show, params: { id: @equipment_piece }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @equipment_piece }
    assert_response :success
  end

  test "should update equipment_piece" do
    patch :update, params: { id: @equipment_piece, equipment_piece: { equipment_type_id: @equipment_piece.equipment_type_id } }
    assert_redirected_to @equipment_piece
  end

  test "should fail to update" do
    patch :update, params: { id: @equipment_piece, equipment_piece: { equipment_type_id: nil } }
    assert_response 200
  end

  test "should destroy equipment_piece" do
    @request.env['HTTP_REFERER'] = equipment_pieces_path
    assert_difference('EquipmentPiece.count', -1) do
      delete :destroy, params: { id: @equipment_piece }
    end

    assert_redirected_to equipment_pieces_path
  end

  test "can get modifier choices appropriate to an equipment_piece" do
    get :modifiers_for_piece, params: {:equipment_piece_id => @equipment_piece.id, :equipment_type_id => @equipment_type.id, :title => "true" }
    assert_response :success
    assert_select "span", { :text => "Equipment Piece Modifiers" }
    assert_select "span", { :text => "none applicable" }
  end
end
