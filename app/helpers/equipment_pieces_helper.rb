module EquipmentPiecesHelper
  def pretty_print_equipment_piece(equipment_piece)
    cost = number_to_currency equipment_piece.cost
    namestring = get_name_string(equipment_piece)
    modlist = get_modifier_list(equipment_piece)
    "#{namestring}#{equipment_piece.equipment_type_name} (#{modlist}#{cost}; #{formatted_weight(equipment_piece)})"
  end

  def pretty_print_equipment_piece_modifiers(equipment_piece)
    return nil unless equipment_piece.equipment_modifiers.any?
    equipment_piece.equipment_modifiers.map { |em| em.name }.join(", ")
  end

  private

  def get_modifier_list(equipment_piece)
    modlist = pretty_print_equipment_piece_modifiers equipment_piece
    modlist += "; " unless modlist.blank?
    modlist
  end

  def get_name_string(equipment_piece)
    "#{equipment_piece.name}: " if equipment_piece.name?
  end
  def formatted_weight(equipment_piece)
    wt = ("%g" % equipment_piece.weight)
    wt == 0 ? "neg." : "#{wt}#"
  end
end
