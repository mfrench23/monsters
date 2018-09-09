# Controller functionality specific to the RpmRitualVariant model
class RpmRitualVariantsController < ModelBasedController

  def create
    entity = RpmRitualVariant.new(whitelisted_entity_params)
    did_save = entity.save
    respond_to_data_change entity, did_save, Value_Set_Created
  end

  private

  def respond_to_data_change(entity, save_ok, value_set)
    created_or_updated_string, show_status, error_page = value_set
    respond_to do |format|
      if save_ok && entity.errors.size() == 0
        format.html { redirect_to entity.rpm_ritual, notice: "Variant was successfully created." }
      else
        format.html { redirect_to entity.rpm_ritual, notice: "Variant was NOT successfully created." }
      end
    end
  end

  def whitelisted_entity_params
    params.fetch(:rpm_ritual_variant, {}).permit(     
      [:name, :rpm_ritual_id,
        rpm_ritual_variant_modifiers_attributes: [:id, :rpm_modifier_level_id, :rpm_modifier_subtype_id, :notes, :enhancement_only, :enhancement_percentage, :enhancement_notes, :_destroy] ] )
  end
end
