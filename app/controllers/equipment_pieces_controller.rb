# Controller functionality specific to the EquipmentPiece model
class EquipmentPiecesController < ModelBasedController

  def modifiers_for_piece
    render locals: EquipmentPiecesController.modifiers_for_piece_local_hash(params), :layout => false
  end

  private

  def self.modifiers_for_piece_local_hash(params)
    param_piece_id, param_type_id, base_id, title = EquipmentPiecesController.modifiers_for_piece_local_hash_params(params)
    eq_piece = EquipmentPiece.find(param_piece_id) if (param_piece_id.try(:to_i)) > 0
    eq_type = EquipmentType.find(param_type_id)
    mod_list = ([*eq_type.try(:equipment_modifiers)] + [*eq_piece.try(:equipment_modifiers)]).uniq.sort_by{|mod| [mod.equipment_modifier_category_name, mod.name] }
    modifiers_for_piece_local_hash = {:available_intersection_list => mod_list, :target => eq_piece, :base_id => base_id, :title => title }
  end

  def self.modifiers_for_piece_local_hash_params(params)
    param_piece_id = params[:equipment_piece_id]
    param_type_id = params[:equipment_type_id]
    base_id = params[:base_id]
    title = "Equipment Piece Modifiers" if ("true" == params[:title].to_s)
    return param_piece_id, param_type_id, base_id, title
  end

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
