# Controller functionality specific to the EquipmentPackage model
class EquipmentPackagesController < ModelBasedController

  private

  def whitelisted_entity_params
    EquipmentPackageForm.new(params).params
  end

  def acceptable_filter_scopes
    []
  end

  def includes_for_sorting
    [:monster, equipment_pieces: [:equipment_type] ]
  end
end
