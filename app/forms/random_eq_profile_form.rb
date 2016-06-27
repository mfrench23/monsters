# Organizes the collection of parameters for a single instance of the EquipmentType model
class RandomEqProfileForm < AbstractEquipmentTypeForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  def self.permitted_attributes
    [:id, :equipment_type_id, :equipment_category_id, :random_weight, :_destroy,
     random_eq_profile_line_items_attributes: [:id, :equipment_modifier_supercategory_id, :quantity, :_destroy]]
  end

  private

  def whitelisted_params(params)
    params.require(:random_eq_profile).permit( RandomEqProfileForm.permitted_attributes )
  end
end
