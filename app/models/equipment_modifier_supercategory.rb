class EquipmentModifierSupercategory < AbstractEntity
  include Nameable

  has_many :equipment_modifier_categories, dependent: :destroy
end
