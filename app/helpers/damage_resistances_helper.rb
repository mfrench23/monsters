module DamageResistancesHelper
  def simpleDR(dr)
    if dr.notes.to_s.strip.length > 0
      notes = " (" + dr.notes + ")"
    end
    (dr.location.blank? ? dr.dr.to_s : [dr.location.to_s, dr.dr.to_s].join(": ") )  + notes.to_s
  end
end
