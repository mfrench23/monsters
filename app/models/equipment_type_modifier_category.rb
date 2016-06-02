# Intersection between EquipmentType and EquipmentModifierCategory, to
# show which categories of modifiers (like "quality modifiers for swords")
# apply to which types of equipment (like "Broadsword" or "Longsword").
class EquipmentTypeModifierCategory < AbstractEntity
  belongs_to :equipment_type
  belongs_to :equipment_modifier_category
end
