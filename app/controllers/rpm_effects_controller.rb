# Controller functionality specific to the RpmEffect model
class RpmEffectsController < ModelBasedController

  private

  def whitelisted_entity_params
    params.fetch(:rpm_effect, {}).permit(:name, :cost, :notes, :campaign_id)
  end
end
