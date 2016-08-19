# Controller functionality specific to the RpmRitual model
class RpmRitualsController < ModelBasedController

  def standard_rpm
    RpmInitializerService.new.standardize(selected_campaign_id)
    redirect_to new_rpm_ritual_path
  end

  private

  def acceptable_filter_scopes
    [:starting_with, :in_campaign]
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
end
