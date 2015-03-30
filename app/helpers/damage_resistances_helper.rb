module DamageResistancesHelper
  def simpleDR dr
    location = ""
    if(!dr.location.nil?)
      location = dr.location.name + ": "
    end

    notes = ""
    if dr.notes.to_s.strip.length > 0
      notes = " (" + dr.notes + ")"
    end

    location + dr.dr.to_s + notes
  end
end
