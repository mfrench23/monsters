class EquipmentTypeModifierCategory < ActiveRecord::Base
  belongs_to :equipment_type
  belongs_to :equipment_modifier_category
end
