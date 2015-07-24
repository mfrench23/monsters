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
    [:name, :equipment_type_id
    ]
  end
end
