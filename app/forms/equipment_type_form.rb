class EquipmentTypeForm
  attr_reader :params

  def initialize(params=nil)
    @params = whitelisted_params(params)
    convert_new_equipment_category_name
  end

  private

  def convert_new_equipment_category_name
    # if :equipment_category_id is numeric, it's an id handled by the autocomplete gem, but
    # if it's NOT numeric, it's something new that the user entered, and needs to be
    # created as a new category.
    unless @params[:equipment_category_id] == @params[:equipment_category_id].to_i.to_s
      cat = EquipmentCategory.new(:name => @params[:equipment_category_id])
      if cat.save
        @params[:equipment_category_id] = cat.id
      end
    end
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
