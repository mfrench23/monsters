class EquipmentCategoriesController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:equipment_category).permit(:name)
  end
end
