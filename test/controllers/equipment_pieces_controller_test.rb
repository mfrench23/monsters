require 'test_helper'

class EquipmentPiecesControllerTest < ActionController::TestCase
  setup do
    @equipment_piece = FactoryGirl.create(:equipment_piece)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create equipment_piece" do
    name = "The Mighty Broadsword Of Ick-Wiki-Wiki-KerTHUMP!"
    assert_difference('EquipmentPiece.count') do
      post :create, equipment_piece: { equipment_type_id: @equipment_piece.equipment_type_id, name: name }
    end

    assert_response :found
    assert_equal "Equipment piece was successfully created.", flash[:notice]
    equipment_piece = EquipmentPiece.where(:name => name ).order("created_at desc").first
    assert_not_nil equipment_piece
    assert_redirected_to equipment_piece
  end

  test "should fail to create equipment_piece" do
    assert_no_difference('EquipmentPiece.count') do
      post :create, equipment_piece: { :equipment_type_id => nil, :name => nil }
    end

    assert_response 200
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
