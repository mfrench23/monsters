class EquipmentModifierSupercategoriesController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:equipment_modifier_supercategory).permit(:name, :notes )
  end

  def additional_form_locals
    {error_messages: []}
  end
end
