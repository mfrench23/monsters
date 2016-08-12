# Organizes the collection of parameters for a single instance of the RpmModifierForm model
class RpmModifierForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  def self.permitted_attributes
    [:name, :notes, :campaign_id,
        rpm_modifier_subtypes_attributes: [:id, :name, :multiplier, :_destroy],
        rpm_modifier_levels_attributes: [:id, :description, :cost, :include_notes_in_summary, :accepts_enhancements, :_destroy]]
  end

  private

  def whitelisted_params(params)
    params.fetch(:rpm_modifier, {}).permit(RpmModifierForm.permitted_attributes)
  end
end
