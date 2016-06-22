# Organizes the collection of parameters for a single instance of the EquipmentModifierCategory model
class EquipmentModifierCategoryForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  def self.permitted_attributes
    [:name, :notes, :equipment_modifier_supercategory_id,
          equipment_modifiers_attributes: EquipmentModifierForm.permitted_attributes,
          equipment_type_modifier_categories_attributes: [:id, :equipment_type_id, :_destroy] ]
  end

  private

  def whitelisted_params(params)
    params.require(:equipment_modifier_category).permit(EquipmentModifierCategoryForm.permitted_attributes)
  end
end
