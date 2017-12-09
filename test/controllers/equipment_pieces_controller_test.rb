require 'test_helper'

class EquipmentPiecesControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    @eq_category = EquipmentCategory.new(:name => "Knickknacks", :campaign => @campaign)
    @eq_category.save!
    @equipment_type = EquipmentType.new(:name => "Rather Narrow Sword", :base_cost_cents => 1000, 
                                        :base_weight => 9.99, :random_weight => 1, :campaign => @campaign,
                                        :equipment_category => @eq_category)
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

  test "can get an empty list of modifier choices appropriate to an equipment_piece" do
    get :modifiers_for_piece, params: {:equipment_piece_id => @equipment_piece.id, :equipment_type_id => @equipment_type.id, :title => "true" }
    assert_response :success
    assert_select "span", { :text => "Equipment Piece Modifiers" }
    assert_select "span", { :text => "none applicable" }
  end

  test "can get modifier choices appropriate to an equipment_piece" do
    cat = FactoryBot.create(:equipment_modifier_category, :name => "Complex")
    cat.save!
    mod1 = EquipmentModifier.new(equipment_modifier_category: cat, name: 'First exclusionary', random_weight: 1)
    mod1.save!
    mod2 = EquipmentModifier.new(equipment_modifier_category: cat, name: 'Second exclusionary', random_weight: 1)
    mod2.excluded_equipment_modifiers << mod1
    mod2.save!
    mod3 = EquipmentModifier.new(equipment_modifier_category: cat, name: 'Third exclusionary', random_weight: 1)
    mod3.excluded_equipment_modifiers << mod1
    mod3.save!
    equipment_type = EquipmentType.new(:name => "Thing", :base_cost_cents => 1000, 
                                        :base_weight => 9.99, :random_weight => 1, :campaign => @campaign,
                                        :equipment_category => @eq_category)
    equipment_type.equipment_type_modifier_categories << EquipmentTypeModifierCategory.new(:equipment_modifier_category => cat)
    equipment_type.save!
    equipment_piece = FactoryBot.create(:equipment_piece, :equipment_type => equipment_type, :quantity => 1, :equipment_modifiers => [mod3] )

    get :modifiers_for_piece, params: {:equipment_piece_id => equipment_piece.id, :equipment_type_id => equipment_type.id, :title => "true", :base_id => "base_id_" }
    assert_response :success

    assert_select "span", { :text => "Equipment Piece Modifiers" }
    assert_select "td[colspan=\"5\"]", /^Complex\s+-\+\s+select all\s+de-select all/ # has EquipmentModifierCategory header
    assert_select "tr[data-toggle_id=\"base_id_equipment_piece_modifiers_sub1\"]" do
      assert_select "td", 3 # TODO expecting 3 columns - but really should expect 5
      assert_select "td" do
        assert_select "span[class=\"many_to_many_cell\"]", /^First exclusionary$/ do
          assert_select "input:not([value])[type=\"hidden\"][name=\"base_id_[0][id]\"]", 1 # no id, not selected
          assert_select "input[type=\"hidden\"][name=\"base_id_[0][equipment_modifier_id]\"][value=\"#{mod1.id}\"]" # id for 1st mod
          assert_select "input[type=\"hidden\"][name=\"base_id_[0][excluded_equipment_modifiers][0]\"][value=\"#{mod2.id}\"]" # 1st mod excludes 2nd
          assert_select "input[type=\"hidden\"][name=\"base_id_[0][excluded_equipment_modifiers][1]\"][value=\"#{mod3.id}\"]" # 1st mod excludes 3rd
          assert_select "input[type=\"hidden\"][name=\"base_id_[0][_destroy]\"][value=\"true\"]" # destroy if not selected
          assert_select "input[type=\"checkbox\"][name=\"base_id_[0][_destroy]\"][value=\"false\"][onclick=\"disable_excluded_equipment_modifiers(this)\"]" # checkbox
        end
      end
      assert_select "td" do
        assert_select "span[class=\"many_to_many_cell\"]", /^Second exclusionary$/ do
          assert_select "input:not([value])[type=\"hidden\"][name=\"base_id_[1][id]\"]", 1 # no id, not selected
          assert_select "input[type=\"hidden\"][name=\"base_id_[1][equipment_modifier_id]\"][value=\"#{mod2.id}\"]" # id for 2nd mod
          assert_select "input[type=\"hidden\"][name=\"base_id_[1][excluded_equipment_modifiers][0]\"][value=\"#{mod1.id}\"]" # 2nd mod excludes 1st
          assert_select "input[type=\"hidden\"][name=\"base_id_[1][_destroy]\"][value=\"true\"]" # destroy if not selected
          assert_select "input[type=\"checkbox\"][name=\"base_id_[1][_destroy]\"][value=\"false\"][onclick=\"disable_excluded_equipment_modifiers(this)\"]" # checkbox
        end
      end
      assert_select "td" do
        assert_select "span[class=\"many_to_many_cell\"]", /^Third exclusionary$/ do
          assert_select "input[type=\"hidden\"][name=\"base_id_[2][id]\"][value=?]", equipment_piece.equipment_piece_modifiers.first.id.to_s # has id for intersection table, because the modifier is on the equipment_piece
          assert_select "input[type=\"hidden\"][name=\"base_id_[2][equipment_modifier_id]\"][value=\"#{mod3.id}\"]" # id for 3rd mod
          assert_select "input[type=\"hidden\"][name=\"base_id_[2][excluded_equipment_modifiers][0]\"][value=\"#{mod1.id}\"]" # 3rd mod excludes 1st
          assert_select "input[type=\"hidden\"][name=\"base_id_[2][_destroy]\"][value=\"true\"]" # destroy if not selected
          assert_select "input[type=\"checkbox\"][name=\"base_id_[2][_destroy]\"][value=\"false\"][onclick=\"disable_excluded_equipment_modifiers(this)\"][checked=\"checked\"]" # checkbox
        end
      end
    end
  end
end
