# A grouping of EquipmentModifierCategories, like "Quality" (including "Quality, Armor", "Quality,
# Weapons" and "Quality, Other stuff")
class EquipmentModifierSupercategory < AbstractEntity
  include Nameable

  has_many :equipment_modifier_categories, dependent: :destroy
  has_many :random_eq_profile_line_items, dependent: :destroy

  has_many :equipment_modifiers, :through => :equipment_modifier_categories
end
