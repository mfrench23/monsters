# A group of EquipmentModifiers, like "Quality, Armor" (including "Cheap", "Good" and "Fine")
class EquipmentModifierCategory < AbstractEntity
  include Nameable

  belongs_to :equipment_modifier_supercategory

  has_many :equipment_type_modifier_categories, dependent: :destroy
  accepts_nested_attributes_for :equipment_type_modifier_categories, allow_destroy: true

  has_many :equipment_modifiers, dependent: :destroy
  accepts_nested_attributes_for :equipment_modifiers, allow_destroy: true, :reject_if => lambda { |modifier| modifier['name'].blank? }

  has_many :equipment_type_modifier_categories, dependent: :destroy
  has_many :equipment_types, through: :equipment_type_modifier_categories

  delegate :name, to: :equipment_modifier_supercategory, prefix: true, allow_nil: true
end
