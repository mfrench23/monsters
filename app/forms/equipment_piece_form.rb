# Organizes the collection of parameters for a single instance of the EquipmentPiece model
class EquipmentPieceForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  private

  def whitelisted_params(params)
    params.require(:equipment_piece).permit( permitted_attributes )
  end

  def permitted_attributes
    [:id, :name, :equipment_type_id, :quantity,
     equipment_piece_modifiers_attributes: [:id, :equipment_modifier_id, :notes, :_destroy]
    ]
  end
end
