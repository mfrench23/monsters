class EquipmentModifierSupercategory < AbstractEntity
  include Nameable

  has_many :equipment_modifier_categories, dependent: :destroy
  has_many :random_eq_profile_line_items, dependent: :destroy
end
