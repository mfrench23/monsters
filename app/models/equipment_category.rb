# A general class of equipment, like "Weapons" or "Clothing".
class EquipmentCategory < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :equipment_types
  scope :order_by_name, -> { order(:name) }

  def to_s
    name
  end
end
