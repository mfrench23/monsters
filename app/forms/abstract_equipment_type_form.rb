class AbstractEquipmentTypeForm < AbstractForm

  private

  def convert_new_equipment_category_name
    cat = EquipmentCategory.find_or_create_by(:name => @params[:equipment_category_name] )
    set_equipment_category_id cat
  end

  def set_equipment_category_id equipment_category
    @params[:equipment_category_id] = equipment_category.id unless equipment_category.nil?
  end
end
