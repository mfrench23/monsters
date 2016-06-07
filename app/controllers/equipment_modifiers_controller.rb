# Controller functionality specific to the EquipmentModifier model
class EquipmentModifiersController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:equipment_modifier).permit([:name, :base_cost_mod, :base_weight_mod, :cost_mod, :weight_mod, :notes, :equipment_modifier_category_id,
                                               equipment_modifier_exclusions_attributes: [:id, :equipment_modifier_id, :excluded_id, :_destroy]
                                              ])
  end

  def additional_form_locals
    query = EquipmentModifier.all
    query = query.where('equipment_modifiers.id != ' + params[:id].to_s) if params[:id].present?
    { excludable_modifiers: query.order_by_category_and_name }
  end

  def includes_for_sorting
    [:equipment_modifier_category]
  end

  def acceptable_filter_scopes
    [:created_on, :updated_on]
  end
end
