class EquipmentPieceForm
  attr_reader :params

  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  private

  def whitelisted_params(params)
    params.require(:equipment_piece).permit( permitted_attributes )
  end

  def permitted_attributes
    [:name, :equipment_type_id,
      equipment_modifiers_attributes: [:id, :name, :base_cost_mod, :base_weight_mod, :cost_mod, :weight_mod, :_destroy]
    ]
  end
end
