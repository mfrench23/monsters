module EquipmentPiecesHelper
  def pretty_print_equipment_piece(equipment_piece)
    @equipment_piece = equipment_piece
    "#{get_name_string}#{get_type_description} (#{formatted_modifiers}#{individual_weight_and_cost}#{combined_weight_and_cost})"
  end

  def pretty_print_equipment_piece_modifiers equipment_piece
    return nil unless equipment_piece.equipment_modifiers.any?
    equipment_piece.equipment_modifiers.map { |em| em.name }.join(", ")
  end

  private

  def get_type_description
    quantity = "#{@equipment_piece.quantity} " if @equipment_piece.quantity > 1
    designation = get_type_designation
    "#{quantity}#{designation}"
  end

  def get_type_designation
    if @equipment_piece.unit_of_measurement.to_s.empty?
      "#{@equipment_piece.equipment_type_name}".pluralize(@equipment_piece.quantity)
    else
      "#{@equipment_piece.unit_of_measurement}".pluralize(@equipment_piece.quantity) + " #{@equipment_piece.equipment_type_name}"
    end
  end

  def combined_weight_and_cost
    return unless @equipment_piece.quantity > 1
    "; total #{formatted_combined_weight}, #{formatted_combined_cost}"
  end

  def individual_weight_and_cost
    ea = ( @equipment_piece.quantity > 1 ? "each " : "" )
    "#{ea}#{formatted_individual_weight}, #{formatted_individual_cost}"
  end

  def formatted_individual_cost
    format_cost @equipment_piece.cost
  end

  def formatted_combined_cost
    format_cost @equipment_piece.total_cost
  end

  def format_cost(cost)
    number_to_currency cost
  end

  def formatted_modifiers
    modlist = pretty_print_equipment_piece_modifiers @equipment_piece
    modlist += "; " unless modlist.blank?
    modlist
  end

  def get_name_string
    "#{@equipment_piece.name}: " if @equipment_piece.name?
  end

  def formatted_combined_weight
    format_weight @equipment_piece.total_weight
  end

  def formatted_individual_weight
    format_weight @equipment_piece.weight
  end

  def format_weight(weight)
    wt = ("%g" % weight)
    wt == 0 ? "neg." : "#{wt}#"
  end
end
