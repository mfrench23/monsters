# A group of EquipmentModifiers, like "Quality" (including "Cheap", "Good" and "Fine")
class EquipmentModifierCategory < AbstractEntity
  include Nameable

  has_many :equipment_modifiers, dependent: :destroy
  accepts_nested_attributes_for :equipment_modifiers, allow_destroy: true, :reject_if => lambda { |x| x['name'].blank? }

  has_many :equipment_modifiers, dependent: :destroy
  accepts_nested_attributes_for :equipment_modifiers, allow_destroy: true
end
