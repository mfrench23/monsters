# Organizes the collection of parameters for a single instance of the EquipmentType model
class EquipmentTypeForm < AbstractEquipmentTypeForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
    convert_new_equipment_category_name
  end

  def self.permitted_attributes
    [:name, :base_weight, :base_cost,
     :equipment_category_name, :equipment_category_id, :notes,
     :unit_of_measurement, :random_weight,
     campaign_contents_attributes: [:id, :campaign_id, :_destroy],
     page_references_attributes: [:id, :book_id, :pages, :_destroy],
     equipment_modifier_categories_attributes: [:id, :name, :notes, :_destroy],
     equipment_type_modifier_categories_attributes: [:id, :equipment_modifier_category_id, :_destroy],
     random_eq_profiles_attributes: RandomEqProfileForm.permitted_attributes
     ]
  end

  private

  def whitelisted_params(params)
    params.require(:equipment_type).permit( EquipmentTypeForm.permitted_attributes )
  end
end
