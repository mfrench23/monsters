# Organizes the collection of parameters for a single instance of the EquipmentPackage model
class EquipmentPackageForm < AbstractForm
  def initialize(params=nil)
    @params = whitelisted_params(params)
  end

  def self.permitted_attributes
    [:id, :_destroy, :creature_id, :name, :notes,
        equipment_pieces_attributes: EquipmentPieceForm.permitted_attributes]
  end

  private

  def whitelisted_params(params)
    params.require(:equipment_package).permit( EquipmentPackageForm.permitted_attributes )
  end
end
