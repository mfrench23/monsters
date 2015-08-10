class EquipmentTypeForm < AbstractEquipmentTypeForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
    convert_new_equipment_category_name
  end

  private

  def whitelisted_params(params)
    params.require(:equipment_type).permit( permitted_attributes )
  end

  def permitted_attributes
    [:name, :base_weight, :base_cost, :equipment_category_id, :notes,
      campaign_contents_attributes: [:id, :campaign_id, :_destroy],
     ]
  end
end
