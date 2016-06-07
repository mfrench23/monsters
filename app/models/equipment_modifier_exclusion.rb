class EquipmentModifierExclusion < ActiveRecord::Base
  after_save :update_reciprocal

  belongs_to :equipment_modifier
  belongs_to :excluded, :class_name => "EquipmentModifier"

  private

  def update_reciprocal
    if ( ! EquipmentModifierExclusion.exists?(:equipment_modifier_id => self[:excluded_id], :excluded_id => self[:equipment_modifier_id]))
      reciprocal = EquipmentModifierExclusion.new(:equipment_modifier_id => self[:excluded_id], :excluded_id => self[:equipment_modifier_id])
      reciprocal.save!
    end
  end
end
