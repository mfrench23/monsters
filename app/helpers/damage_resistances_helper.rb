module DamageResistancesHelper
  def simpleDR dr
    Location.find(dr.location_id).name + ": " + dr.dr.to_s +
	(dr.notes.length > 0 ? " (" + dr.notes + ")" : "" )
  end
end
