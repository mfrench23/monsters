# A general class of equipment, like "Weapons" or "Clothing".
class EquipmentCategory < AbstractEntity
  include Nameable

  has_many :equipment_types
end
