# Controller functionality specific to the EquipmentPackage model
class EquipmentPackagesController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:equipment_package).permit(:creature_id, :name, :notes,
                                      equipment_pieces_attributes: [:id, :_destroy, :name, :quantity, :equipment_type_id,
                                                                    equipment_piece_modifiers_attributes: [:id, :equipment_modifier_id, :notes, :_destroy]
                                                                    ]
                                              )
  end

  def acceptable_filter_scopes
    []
  end
end
