# A group of EquipmentModifiers, like "Quality" (including "Cheap", "Good" and "Fine")
class EquipmentModifierCategory < AbstractEntity
  include Nameable

  has_many :equipment_type_modifier_categories, dependent: :destroy

  has_many :equipment_modifiers, dependent: :destroy
  accepts_nested_attributes_for :equipment_modifiers, allow_destroy: true, :reject_if => lambda { |modifier| modifier['name'].blank? }

  has_many :equipment_modifiers, dependent: :destroy
  accepts_nested_attributes_for :equipment_modifiers, allow_destroy: true
end
