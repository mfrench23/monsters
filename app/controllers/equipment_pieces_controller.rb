class EquipmentPiecesController < ModelBasedController

  private

  def whitelisted_entity_params
    EquipmentPieceForm.new(params).params
  end

  def includes_for_sorting
    [:equipment_type, :equipment_category]
  end

  def acceptable_filter_scopes
    [:created_on, :updated_on]
  end
end
