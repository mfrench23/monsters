class EquipmentModifierCategoriesController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:equipment_modifier_category).permit(:name, :notes,
          equipment_modifiers_attributes: [:id, :name, :base_cost_mod, :base_weight_mod, :cost_mod, :weight_mod, :notes, :_destroy],
          equipment_type_modifier_categories_attributes: [:id, :equipment_type_id, :_destroy]
      )
  end
end