class EquipmentTypesController < ModelBasedController
  autocomplete :equipment_category, :name, :full => true

  private

  def additional_index_locals
    {campaigns: all_campaigns_with_equipment_types.order_by_name}
  end

  def additional_form_locals
    {campaigns: all_campaigns}
  end

  def all_campaigns_with_equipment_types
    Campaign.has_contents(EquipmentType.to_s)
  end

  def includes_for_sorting
    [:equipment_category]
  end

  def whitelisted_entity_params
    EquipmentTypeForm.new(params).params
  end

  def acceptable_filter_scopes
    [:starting_with, :in_campaign]
  end
end
