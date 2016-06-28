# Controller functionality specific to the Creature model
class CreaturesController < ModelBasedController
  def index
    redirect_to monsters_url
  end

  def variant
    creature = set_model_by_id.deep_copy
    render :new, locals: { creature: creature, campaigns: all_campaigns }
  end

  private

  def whitelisted_entity_params
    CreatureForm.new(params).params.merge({:campaign_id => selected_campaign_id})
  end

  def additional_form_locals
    {campaigns: all_campaigns}
  end
end
