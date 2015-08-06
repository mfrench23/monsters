# An abstract kind of equipment, like "broadsword" or "backpack".
class EquipmentType < AbstractEntity
  include CampaignContained
  include Nameable

  belongs_to :equipment_category

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }
end
