# Organizes the collection of parameters for a single instance of the RpmRitual model
class RpmRitualForm < AbstractForm
  def initialize(params=nil)
    params = clean_enhancements(params)
    @params = whitelisted_params(params)
  end

  def self.permitted_attributes
    [:name, :description, :campaign_id,
        page_references_attributes: [:id, :book_id, :pages, :_destroy],
        rpm_spell_effects_attributes: RpmSpellEffectForm.permitted_attributes,
        rpm_ritual_modifiers_attributes: [:id, :rpm_modifier_level_id, :rpm_modifier_subtype_id, :notes, :inherent, :enhancement_only, :enhancement_percentage, :enhancement_notes, :_destroy] ]
  end

  private

  def clean_enhancements(params)
    return params unless params.present? && params[:rpm_ritual].present? && params[:rpm_ritual][:rpm_ritual_modifiers_attributes].present?
    params[:rpm_ritual][:rpm_ritual_modifiers_attributes].keys.each do |key|
      clean_enhancements_from_hash params[:rpm_ritual][:rpm_ritual_modifiers_attributes][key]
    end
    params
  end

  def clean_enhancements_from_hash(mod_hash)
    level = RpmModifierLevel.find(mod_hash[:rpm_modifier_level_id]) if mod_hash.present? && mod_hash[:rpm_modifier_level_id].present?
    unless level.present? && level.accepts_enhancements
      clear_enhancement_fields(mod_hash)
    end
  end

  def clear_enhancement_fields(mod_hash)
    mod_hash[:enhancement_percentage] = nil
    mod_hash[:enhancement_notes] = nil
    mod_hash[:enhancement_only] = false
  end

  def whitelisted_params(params)
    params.fetch(:rpm_ritual, {}).permit( RpmRitualForm.permitted_attributes )
  end
end
