class EquipmentTypeForm
  attr_reader :params

  def initialize(params=nil)
    @params = whitelisted_params(params)
    convert_new_equipment_category_name
  end

  private

  def convert_new_equipment_category_name
    cat = EquipmentCategory.find_or_create_by(:name => @params[:equipment_category_id] )
    set_equipment_category_id cat
  end

  def set_equipment_category_id equipment_category
    @params[:equipment_category_id] = equipment_category.id unless equipment_category.nil?
  end

  def whitelisted_params(params)
    params.require(:equipment_type).permit( permitted_attributes )
  end

  def permitted_attributes
    [:name, :base_weight, :base_cost, :equipment_category_id, :notes,
      campaign_contents_attributes: [:id, :campaign_id, :_destroy],
     ]
  end
end
