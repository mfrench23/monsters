# An abstract kind of equipment, like "broadsword" or "backpack".
class EquipmentType < AbstractEntity
  include CampaignContained
  include Dateable
  include Nameable
  include PageReferenceable

  attr_accessor :equipment_category_name

  belongs_to :equipment_category

  has_many :equipment_type_modifier_categories, dependent: :destroy
  accepts_nested_attributes_for :equipment_type_modifier_categories, allow_destroy: true
  has_many :equipment_modifier_categories, through: :equipment_type_modifier_categories
  has_many :equipment_modifiers, through: :equipment_modifier_categories

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }

  delegate :name, to: :equipment_category, prefix: true

  validates :equipment_category, presence: true

  scope :in_equipment_category, -> (equipment_category_id) { where('equipment_category_id = ?', equipment_category_id) }

  def equipment_category_name
    equipment_category.name unless equipment_category.nil?
  end

  def self.parse(text, equipment_category_id)
    EquipmentType.new( :name => extract_name(text), :base_cost => extract_cost(text), :base_weight => extract_weight(text), :equipment_category_id => equipment_category_id)
  end

  private

  def self.extract_name(text)
    if m = text.to_s.match( /^(.*) *\(/ )
      m[1].strip
    end
  end

  def self.extract_cost(text)
    if m = text.to_s.match( /\$([\d,.]+)/ )
      m[1].strip
    end
  end

  def self.extract_weight(text)
    if m = text.to_s.match( /([\d,.]+)#/ )
      m[1].strip
    end
  end
end
