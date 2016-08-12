# Controller functionality specific to the RpmModifier model
class RpmModifiersController < ModelBasedController

  private

  def whitelisted_entity_params
    params.fetch(:rpm_modifier, {}).permit(:name, :notes, :campaign_id,
                                           rpm_modifier_levels_attributes: [:id, :description, :cost, :include_notes_in_summary, :accepts_enhancements, :_destroy])
  end
end
