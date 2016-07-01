# Controller functionality specific to the EquipmentType model
class EquipmentTypesController < ModelBasedController
  autocomplete :equipment_category, :name, :full => true

  def mass_entry
    render :mass_entry, locals: additional_form_locals
  end

  def do_mass_entry
    form = EquipmentTypeMassEntryForm.new(params, selected_campaign_id)
    form.ok? ? save_mass_entry_and_redirect_to_index(form) : render_mass_entry_page_with_error_messages(form)
  end

  private

  def get_autocomplete_items(parameters)
    super(parameters).where(:campaign_id => selected_campaign_id)
  end

  def render_mass_entry_page_with_error_messages(form)
    flash[:notice] = "Unable to convert into equipment types: Errors exist."
    render :mass_entry, locals: mass_entry_locals(form)
  end

  def save_mass_entry_and_redirect_to_index(form)
    save_mass_entry_entities form
    redirect_to index_url, notice: ""
  end

  def save_mass_entry_entities(form)
    form.equipment_types.each do |equipment_type|
      equipment_type.equipment_category_id = form.equipment_category_id
      equipment_type.save!
    end
  end

  def mass_entry_locals(form)
    paramz = form.params
    additional_form_locals.merge({:freeform_text => paramz[:freeform_text],
                                :equipment_category_name => paramz[:equipment_category_name],
                                :error_messages => form.error_messages })
  end

  def additional_index_locals
    {equipment_categories: EquipmentCategory.in_campaign(selected_campaign_id) }
  end

  def additional_form_locals
    {equipment_modifier_categories: EquipmentModifierCategory.all,
     error_messages: []}
  end

  def includes_for_sorting
    [:equipment_category]
  end

  def whitelisted_entity_params
    EquipmentTypeForm.new(params, selected_campaign_id).params.merge({:campaign_id => selected_campaign_id})
  end

  def acceptable_filter_scopes
    [:starting_with, :created_on, :updated_on, :in_campaign, :in_equipment_category]
  end
end
