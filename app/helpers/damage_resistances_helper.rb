module DamageResistancesHelper
  def simpleDR(dr)
    if dr.notes.to_s.strip.length > 0
      notes = " (" + dr.notes + ")"
    end

    if dr.location.to_s.empty?
      pre = dr.dr.to_s
    else
      pre = [dr.location.to_s, dr.dr.to_s].join(": ")
    end

    pre.to_s + notes.to_s
  end
end
