# A group of individual pieces of equipment considered as a whole; for example,
# all of a given adventurer's kit or the normal load-out for a certain monster.
class EquipmentPackage < AbstractEntity
  include EquipmentOwning

  before_save :calculate_values

  belongs_to :monster
  monetize :total_cost_cents, :numericality => { :greater_than_or_equal_to => 0 }

  def final_owner
    monster
  end

  def deep_copy
    copy = dup
    reference_list_attributes.each { |reference| deep_copy_reference(reference, copy) }
    copy
  end

  def total_cost_cents
    self[:total_cost_cents] = equipment_pieces.map(&:total_cost_cents).inject(&:+) || 0
    self[:total_cost_cents]
  end

  def total_weight
    self[:total_weight] = equipment_pieces.map(&:total_weight).inject(&:+) || 0
    self[:total_weight]
  end

  private

  def calculate_values
    total_weight
    total_cost_cents
    return
  end

  def reference_list_attributes
    [:equipment_pieces]
  end
end
