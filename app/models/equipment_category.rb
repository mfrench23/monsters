# A general class of equipment, like "Weapons" or "Clothing".
class EquipmentCategory < AbstractEntity
  include UniquelyNameable

  has_many :equipment_types
end
