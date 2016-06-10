# Links two EquipmentModifier instances to show that the first is incompatible with the second
class EquipmentModifierExclusion < ActiveRecord::Base
  after_save :update_reciprocal
  after_destroy :destroy_reciprocal

  belongs_to :equipment_modifier
  belongs_to :excluded, :class_name => "EquipmentModifier"

  validates_uniqueness_of :equipment_modifier_id, scope: :excluded_id

  private

  def update_reciprocal
    excluded_id, equipment_modifier_id = self[:excluded_id], self[:equipment_modifier_id]
    if ( ! EquipmentModifierExclusion.exists?(:equipment_modifier_id => excluded_id, :excluded_id => equipment_modifier_id))
      reciprocal = EquipmentModifierExclusion.new(:equipment_modifier_id => excluded_id, :excluded_id => equipment_modifier_id)
      reciprocal.save!
    end
  end

  def destroy_reciprocal
    excluded_id, equipment_modifier_id = self[:excluded_id], self[:equipment_modifier_id]
    if ( EquipmentModifierExclusion.exists?(:equipment_modifier_id => excluded_id, :excluded_id => equipment_modifier_id))
      reciprocal = EquipmentModifierExclusion.new(:equipment_modifier_id => excluded_id, :excluded_id => equipment_modifier_id)
      reciprocal.destroy!
    end
  end
end
