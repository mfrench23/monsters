# Controller functionality specific to the EquipmentModifierCategory model
class EquipmentModifierCategoriesController < ModelBasedController

  private

  def whitelisted_entity_params
    EquipmentModifierCategoryForm.new(params).params
  end

  def additional_form_locals
    {error_messages: [],
     table_spec: ManyToManyCheckboxTableSpecification.new(subheader_field: :equipment_category_name,
                                                          available_intersection_list: EquipmentType.all.order_by_category_and_name,
                                                          intersection_field: :equipment_type,
                                                          target: @model, member_name: :equipment_type_modifier_categories) }
  end

  def includes_for_sorting
    [:equipment_modifier_supercategory]
  end
end
