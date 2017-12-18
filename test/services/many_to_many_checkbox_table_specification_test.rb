require 'test_helper'

class ManyToManyCheckboxTableSpecificationTest < ActionView::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    @eq_category = EquipmentCategory.new(:name => "Knickknacks", :campaign => @campaign)
    @eq_category.save!

    cat = FactoryBot.create(:equipment_modifier_category, :name => "Complex")
    cat.save!
    mod2 = EquipmentModifier.new(equipment_modifier_category: cat, name: 'Second exclusionary', random_weight: 1)
    mod2.save!
    mod1 = EquipmentModifier.new(equipment_modifier_category: cat, name: 'First exclusionary', random_weight: 1)
    mod1.excluded_equipment_modifiers << mod2
    mod1.save!
    mod3 = EquipmentModifier.new(equipment_modifier_category: cat, name: 'Third exclusionary', random_weight: 1)
    mod3.excluded_equipment_modifiers << mod1
    mod3.save!
    equipment_type = EquipmentType.new(:name => "Thing", :base_cost_cents => 1000, 
                                        :base_weight => 9.99, :random_weight => 1, :campaign => @campaign,
                                        :equipment_category => @eq_category)
    equipment_type.equipment_type_modifier_categories << EquipmentTypeModifierCategory.new(:equipment_modifier_category => cat)
    equipment_type.save!
    @equipment_piece = FactoryBot.create(:equipment_piece, :equipment_type => equipment_type, :quantity => 1, :equipment_modifiers => [mod3] )

    @table_spec = ManyToManyCheckboxTableSpecification.new(subheader_field: :equipment_modifier_category_name,
                                                           available_intersection_list: equipment_type.try(:equipment_modifiers).includes(:equipment_modifier_category),
                                                           intersection_field: :equipment_modifier,
                                                           target: @equipment_piece, member_name: :equipment_piece_modifiers)
  end

  test "should get out what you put in" do
    assert_equal "Complex", @table_spec.item_hash.keys.first

    assert_equal 1, @table_spec.item_hash["Complex"][:count_of_selected]

    mem = @table_spec.item_hash["Complex"][:members].first
    assert_equal "First exclusionary", mem[:display_text]

    mem = @table_spec.item_hash["Complex"][:members].last
    assert_equal "Third exclusionary", mem[:display_text]
  end
end
