# A general class of equipment, like "Weapons" or "Clothing".
class EquipmentCategory < AbstractEntity
  include CampaignContained
  include Nameable

  has_many :equipment_types

  has_many :random_eq_profiles, dependent: :destroy
  accepts_nested_attributes_for :random_eq_profiles, allow_destroy: true

  validates_uniqueness_of :name, :scope => :campaign_id

  # Given another EquipmentCategory, take over the EquipmentTypes it is responsible for, and delete it.
  def merge(dupe)
    return false if self == dupe
    dupe.equipment_types.update_all(equipment_category_id: self.id)
    dupe.destroy
  end

end
