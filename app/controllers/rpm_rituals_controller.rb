# Controller functionality specific to the RpmRitual model
class RpmRitualsController < ModelBasedController

  def grid
    render locals: { :grid_data => RpmRitualGridService.new.grid(selected_campaign_id) }
  end

  def standard_rpm
    RpmInitializerService.new.standardize(selected_campaign_id)
    redirect_to new_rpm_ritual_path
  end

  def full_book
    respond_to do |format|
      format.pdf do
        render :layout => false, locals: { :campaign => Campaign.find(selected_campaign_id), :view_context => view_context }
      end
    end
  end

  def duplicate
    instance = set_model_by_id.deep_copy
    instance.campaign_id = selected_campaign_id if instance.respond_to? :campaign_id
    render :new, locals: locals_hash(instance)
  end

  private

  def campaign_paths
    RpmPath.in_campaign(selected_campaign_id).order_by_name
  end

  def acceptable_filter_scopes
    [:starting_with, :in_campaign, :with_path]
  end

  def additional_index_locals
    {rpm_paths: campaign_paths }
  end

  def additional_form_locals
    campaign_id = selected_campaign_id
    { rpm_modifiers: RpmModifier.in_campaign(campaign_id).order_by_name,
      rpm_modifier_levels_accepting_enhancements: rpm_modifier_levels_accepting_enhancements(campaign_id) }
  end

  def whitelisted_entity_params
    RpmRitualForm.new(params).params
  end

  def rpm_modifier_levels_accepting_enhancements(campaign_id)
    RpmModifierLevel.in_campaign(campaign_id).where(:accepts_enhancements => true).pluck(:id)
  end

  def includes_for_sorting
    [rpm_spell_effects: [:rpm_potency, :rpm_effect, :rpm_path], rpm_ritual_modifiers: [:rpm_modifier, :rpm_modifier_subtype, :rpm_modifier_level]]
  end
end
