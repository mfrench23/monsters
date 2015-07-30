# An abstract kind of equipment, like "broadsword" or "backpack".
class EquipmentType < ActiveRecord::Base
  include CampaignContained
  include Filterable

  belongs_to :equipment_category

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }

  scope :starting_with, -> (name) { where("upper(name) like ?", "#{name}%")}
  scope :order_by_name, -> { order(:name) }

  validates :name, presence: true
  validates_uniqueness_of :name

  def to_s
    name
  end
end
