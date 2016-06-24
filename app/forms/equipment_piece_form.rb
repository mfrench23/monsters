# Organizes the collection of parameters for a single instance of the EquipmentPiece model
class EquipmentPieceForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  def self.permitted_attributes
    [:id, :name, :equipment_type_id, :quantity, :_destroy,
     equipment_piece_modifiers_attributes: [:id, :equipment_modifier_id, :notes, :_destroy] ]
  end

  private

  def whitelisted_params(params)
    params.require(:equipment_piece).permit( EquipmentPieceForm.permitted_attributes )
  end
end
