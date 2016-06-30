# An abstract kind of equipment, like "broadsword" or "backpack".
class EquipmentType < AbstractEntity
  include CampaignContained
  include Dateable
  include Nameable
  include PageReferenceable
  include RandomlyOrderable

  attr_accessor :equipment_category_name

  belongs_to :equipment_category

  has_many :equipment_type_modifier_categories, dependent: :destroy
  accepts_nested_attributes_for :equipment_type_modifier_categories, allow_destroy: true
  has_many :equipment_modifier_categories, through: :equipment_type_modifier_categories
  has_many :equipment_modifiers, through: :equipment_modifier_categories
  has_many :random_eq_profiles, dependent: :destroy
  accepts_nested_attributes_for :random_eq_profiles, allow_destroy: true

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }

  delegate :name, to: :equipment_category, prefix: true

  validates :equipment_category, presence: true
  validates_uniqueness_of :name, :scope => :campaign_id

  scope :in_equipment_category, -> (equipment_category_id) { where('equipment_category_id = ?', equipment_category_id) }
  scope :order_by_category_and_name, -> { joins(:equipment_category).order('equipment_categories.name, equipment_types.name') }

  def equipment_category_name
    equipment_category.try(:name)
  end

  def self.parse(text, equipment_category_id)
    EquipmentType.new( :name => extract_name(text), :base_cost => extract_cost(text), :base_weight => extract_weight(text), :equipment_category_id => equipment_category_id, :random_weight => 1)
  end

  private

  def self.extract_name(text)
    if matched = text.to_s.match( /^(.*) *\(/ )
      matched[1].strip
    end
  end

  def self.extract_cost(text)
    if matched = text.to_s.match( /\$([\d,.]+)/ )
      matched[1].strip
    end
  end

  def self.extract_weight(text)
    if matched = text.to_s.match( /([\d,.]+)#/ )
      matched[1].strip
    end
  end
end
