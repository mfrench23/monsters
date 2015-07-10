module DamageResistancesHelper
  def simpleDR(dr)
    location(dr).to_s + score(dr) + notes(dr).to_s
  end

  private

  def score(dr)
    dr.dr.to_s
  end

  def location(dr)
    dr.location.to_s + ": " unless dr.location.blank?
  end

  def notes(dr)
    " (" + dr.notes + ")" unless dr.notes.blank?
  end
end
