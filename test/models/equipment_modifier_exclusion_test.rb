require 'test_helper'

class EquipmentModifierExclusionTest < ActiveSupport::TestCase
  test "insert creates reciprocal, destroy deletes it" do
    cat = FactoryBot.create(:equipment_modifier_category)
    mod1 = EquipmentModifier.new(equipment_modifier_category: cat, name: 'First exclusionary', random_weight: 1)
    mod1.save!
    mod2 = EquipmentModifier.new(equipment_modifier_category: cat, name: 'Second exclusionary', random_weight: 1)
    mod2.excluded_equipment_modifiers << mod1
    mod2.save!
    mod1id = mod1.id
    mod2id = mod2.id
    assert_equal 1, EquipmentModifierExclusion.where(equipment_modifier_id: mod2id, excluded_id: mod1id).count
    assert_equal 1, EquipmentModifierExclusion.where(equipment_modifier_id: mod1id, excluded_id: mod2id).count
    mod2.destroy
    assert_equal 0, EquipmentModifierExclusion.where(equipment_modifier_id: mod2id, excluded_id: mod1id).count
    assert_equal 0, EquipmentModifierExclusion.where(equipment_modifier_id: mod1id, excluded_id: mod2id).count
  end
end
