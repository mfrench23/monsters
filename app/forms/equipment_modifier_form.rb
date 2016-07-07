# Organizes the collection of parameters for a single instance of the EquipmentModifier model
class EquipmentModifierForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  def self.permitted_attributes
    [:id, :name, :base_cost_mod, :base_weight_mod, :cost_mod, :weight_mod,
     :notes, :equipment_modifier_category_id, :mutually_exclusive,
     :random_weight,
     equipment_modifier_exclusions_attributes: [:id, :equipment_modifier_id, :excluded_id, :_destroy] ]
  end

  private

  def whitelisted_params(params)
    params.fetch(:equipment_modifier, {}).permit(EquipmentModifierForm.permitted_attributes)
  end
end
