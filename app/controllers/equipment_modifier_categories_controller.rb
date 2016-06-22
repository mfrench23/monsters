# Controller functionality specific to the EquipmentModifierCategory model
class EquipmentModifierCategoriesController < ModelBasedController

  private

  def whitelisted_entity_params
    EquipmentModifierCategoryForm.new(params).params
  end

  def additional_form_locals
    {equipment_types: EquipmentType.all.order_by_category_and_name, error_messages: []}
  end

  def includes_for_sorting
    [:equipment_modifier_supercategory]
  end
end
