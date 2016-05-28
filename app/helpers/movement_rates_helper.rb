module MovementRatesHelper
  def pretty_movement_rate(mv)
    enh = (mv.enhanced_rate.nil? ? "" : "/" + mv.enhanced_rate.to_s)
    mv.rate.to_s + enh + " (" + mv.move_type_name.to_s + ")"
  end
end
