# Controller functionality specific to the RpmRitual model
class RpmRitualsController < ModelBasedController

  private

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
