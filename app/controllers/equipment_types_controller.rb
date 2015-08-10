class EquipmentTypesController < ModelBasedController
  autocomplete :equipment_category, :name, :full => true

  def mass_entry
    render :mass_entry, locals: additional_form_locals
  end

  def do_mass_entry
    form = EquipmentTypeMassEntryForm.new(params)
    form.ok? ? save_mass_entry_and_redirect_to_index(form) : render_mass_entry_page_with_error_messages(form)
  end

  private

  def render_mass_entry_page_with_error_messages(form)
    flash[:notice] = "Unable to convert into equipment types: Errors exist."
    render :mass_entry, locals: mass_entry_locals(form)
  end

  def save_mass_entry_and_redirect_to_index(form)
    save_mass_entry_entities form
    redirect_to index_url, notice: ""
  end

  def save_mass_entry_entities(form)
    form.equipment_types.each do |et|
      et.equipment_category_id = form.equipment_category_id
      et.save!
    end
  end

  def mass_entry_locals(form)
    additional_form_locals.merge({:freeform_text => form.params[:freeform_text],
                                :equipment_category_id => form.params[:equipment_category_id],
                                :campaign_id => form.params[:campaign_id],
                                :error_messages => form.error_messages })
  end

  def additional_index_locals
    {campaigns: all_campaigns_with_equipment_types.order_by_name}
  end

  def additional_form_locals
    {campaigns: all_campaigns, error_messages: []}
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
