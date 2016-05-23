class EquipmentPieceForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  private

  def whitelisted_params(params)
    params.require(:equipment_piece).permit( permitted_attributes )
  end

  def permitted_attributes
    [:name, :equipment_type_id, :quantity,
     equipment_modifiers_attributes: [:id, :name, :base_cost_mod, :base_weight_mod, :cost_mod, :weight_mod, :notes, :_destroy]
    ]
  end
end
