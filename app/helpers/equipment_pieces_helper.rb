module EquipmentPiecesHelper
  def pretty_print_equipment_piece(equipment_piece)
    modlist = pretty_print_equipment_piece_modifiers equipment_piece
    modlist += "; " unless modlist.blank?
    namestring = "#{equipment_piece.name}: " if equipment_piece.name?
    cost = number_to_currency equipment_piece.cost
    wt = ("%g" % equipment_piece.weight)
    wt = ( wt == 0 ? "neg." : "#{wt}#")
    "#{namestring}#{equipment_piece.equipment_type_name} (#{modlist}#{cost}; #{wt})"
  end

  def pretty_print_equipment_piece_modifiers(equipment_piece)
    return nil unless equipment_piece.equipment_modifiers.any?
    equipment_piece.equipment_modifiers.map { |em| em.name }.join(", ")
  end
end