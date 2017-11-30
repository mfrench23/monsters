# Controller functionality specific to the RpmSpellEffect model
class RpmSpellEffectsController < ModelBasedController

  private

  def acceptable_filter_scopes
    [:inherent_only, :with_potency, :with_effect, :with_path]
  end

  def additional_index_locals
    {rpm_paths: RpmPath.in_campaign(selected_campaign_id).order_by_name,
     rpm_effects: RpmEffect.in_campaign(selected_campaign_id).order_by_name,
     rpm_potencies: RpmPotency.in_campaign(selected_campaign_id).order_by_name,
     rpm_effect_name: (params[:with_effect].present? ? RpmEffect.find(params[:with_effect]).name : nil),
     rpm_potency_name: (params[:with_potency].present? ? RpmPotency.find(params[:with_potency]).name : nil) }
  end

  def includes_for_sorting
    [:rpm_potency, :rpm_effect, :rpm_path, :rpm_ritual]
  end

  def standard_filter_params
    super.merge( { :inherent_only => true } )
  end

  def whitelisted_entity_params
    RpmSpellEffectForm.new(params).params
  end
end
