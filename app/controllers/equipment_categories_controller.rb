# Controller functionality specific to the EquipmentCategory model
class EquipmentCategoriesController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:equipment_category).permit(:name,
                                               random_eq_profiles_attributes: RandomEqProfileForm.permitted_attributes)
  end

  # Hash of locals required by _form view
  def additional_form_locals
    {equipment_modifier_supercategories: EquipmentModifierSupercategory.order_by_name} #TODO Restrict by campaign
  end
end
