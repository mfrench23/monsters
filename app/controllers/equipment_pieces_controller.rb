class EquipmentPiecesController < ModelBasedController

  def modifiers_for_piece
    render locals: modifiers_for_piece_local_hash(params), :layout => false
  end

  private

  def modifiers_for_piece_local_hash(params)
    eq_piece = EquipmentPiece.find(params[:equipment_piece_id])
    eq_type = EquipmentType.find(params[:equipment_type_id])
    mod_list = (eq_type.equipment_modifiers + eq_piece.equipment_modifiers).uniq
    title = "Equipment Piece Modifiers" if ("true" == params[:title].to_s)
    modifiers_for_piece_local_hash = {:available_intersection_list => mod_list, :target => eq_piece, :base_id => params[:base_id], :title => title }
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
