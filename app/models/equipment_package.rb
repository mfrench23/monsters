# A group of individual pieces of equipment considered as a whole; for example,
# all of a given adventurer's kit or the normal load-out for a certain monster.
class EquipmentPackage < AbstractEntity
  include EquipmentOwning

  belongs_to :creature

  def final_owner
    creature
  end

  def deep_copy
    copy = dup
    reference_list_attributes.each { |reference| deep_copy_reference(reference, copy) }
    copy
  end

  private

  def reference_list_attributes
    [:equipment_pieces]
  end
end
