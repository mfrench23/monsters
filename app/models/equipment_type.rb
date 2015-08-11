# An abstract kind of equipment, like "broadsword" or "backpack".
class EquipmentType < AbstractEntity
  include CampaignContained
  include Dateable
  include Nameable
  include PageReferenceable

  belongs_to :equipment_category

  monetize :base_cost_cents, :allow_nil => false, :numericality => { :greater_than_or_equal_to => 0 }

  delegate :name, to: :equipment_category, prefix: true

  validates :equipment_category, presence: true

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
