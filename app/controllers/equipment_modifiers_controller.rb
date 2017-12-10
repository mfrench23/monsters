# Controller functionality specific to the EquipmentModifier model
class EquipmentModifiersController < ModelBasedController

  private

  def whitelisted_entity_params
    EquipmentModifierForm.new(params).params
  end

  def additional_index_locals
    {equipment_modifier_categories: EquipmentModifierCategory.all }
  end

  def additional_form_locals
    { table_spec: ManyToManyCheckboxTableSpecification.new(subheader_field: :equipment_modifier_category_name,
                                                           available_intersection_list: all_modifiers_that_can_be_mutually_exclusive,
                                                           intersection_field: :excluded,
                                                           target: @model, member_name: :equipment_modifier_exclusions) }
  end

  def all_modifiers_that_can_be_mutually_exclusive
    id = params[:id]
    query = EquipmentModifier.all
    query = query.where('equipment_modifiers.id != ' + id.to_s) if id.present? # exclude self
    query.order_by_category_and_name
  end

  def includes_for_sorting
    [:equipment_modifier_category]
  end

  def acceptable_filter_scopes
    [:created_on, :updated_on, :in_modifier_category, :starting_with]
  end
end
