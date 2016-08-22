# Organizes the collection of parameters for a single instance of the RpmSpellEffect model
class RpmSpellEffectForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  def self.permitted_attributes
    [:id, :rpm_ritual_id, :rpm_potency_id, :rpm_effect_id, :rpm_path_id, :notes, :inherent, :_destroy]
  end

  private

  def whitelisted_params(params)
    params.fetch(:rpm_spell_effect, {}).permit( RpmSpellEffectForm.permitted_attributes )
  end
end
