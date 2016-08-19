# Controller functionality specific to the RpmPotency model
class RpmPotenciesController < ModelBasedController

  private

  def acceptable_filter_scopes
    [:starting_with, :in_campaign]
  end

  def whitelisted_entity_params
    params.fetch(:rpm_potency, {}).permit(:name, :cost_factor, :notes, :campaign_id)
  end
end
