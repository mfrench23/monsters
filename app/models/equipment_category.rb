# A general class of equipment, like "Weapons" or "Clothing".
class EquipmentCategory < AbstractEntity
  include UniquelyNameable

  has_many :equipment_types

  has_many :random_eq_profiles, dependent: :destroy
  accepts_nested_attributes_for :random_eq_profiles, allow_destroy: true
end
