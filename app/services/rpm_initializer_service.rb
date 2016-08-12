class RpmInitializerService
  def initialize
  end

  # Given a campaign id, set that campaign up with the standard static data for
  # the off-the-shelf RPM magic system from "GURPS Thaumatology: Ritual Path Magic"
  def standardize(campaign_id)
    return if RpmPotency.where(:campaign_id => campaign_id).any? || RpmEffect.where(:campaign_id => campaign_id).any? || RpmPath.where(:campaign_id => campaign_id).any?
    add_potencies(campaign_id)
    add_effects(campaign_id)
    add_paths(campaign_id)
    add_modifiers(campaign_id)
  end

  private

  def add_potencies(campaign_id)
    RpmPotency.new(:campaign_id => campaign_id, :name => "Lesser", :cost_factor => 1).save!
    RpmPotency.new(:campaign_id => campaign_id, :name => "Greater", :cost_factor => 2).save!
  end

  def add_paths(campaign_id)
    RpmPath.new(:campaign_id => campaign_id, :name => "Body").save!
    RpmPath.new(:campaign_id => campaign_id, :name => "Chance").save!
    RpmPath.new(:campaign_id => campaign_id, :name => "Crossroads").save!
    RpmPath.new(:campaign_id => campaign_id, :name => "Energy").save!
    RpmPath.new(:campaign_id => campaign_id, :name => "Magic").save!
    RpmPath.new(:campaign_id => campaign_id, :name => "Matter").save!
    RpmPath.new(:campaign_id => campaign_id, :name => "Mind").save!
    RpmPath.new(:campaign_id => campaign_id, :name => "Spirit").save!
    RpmPath.new(:campaign_id => campaign_id, :name => "Undead").save!
  end

  def add_effects(campaign_id)
    RpmEffect.new(:campaign_id => campaign_id, :name => "Sense", :cost => 2).save!
    RpmEffect.new(:campaign_id => campaign_id, :name => "Strengthen", :cost => 3).save!
    RpmEffect.new(:campaign_id => campaign_id, :name => "Restore", :cost => 4).save!
    RpmEffect.new(:campaign_id => campaign_id, :name => "Control", :cost => 5).save!
    RpmEffect.new(:campaign_id => campaign_id, :name => "Destroy", :cost => 5).save!
    RpmEffect.new(:campaign_id => campaign_id, :name => "Create", :cost => 6).save!
    RpmEffect.new(:campaign_id => campaign_id, :name => "Transform", :cost => 8).save!
  end

  def add_modifiers(campaign_id)
    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Affliction")
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Stunning", :cost => 0)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Heart Attack", :cost => 60)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Daze", :cost => 10)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Hallucinating", :cost => 10)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Retching", :cost => 10)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Agony", :cost => 20)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Choking", :cost => 20)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Ecstasy", :cost => 20)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Seizure", :cost => 20)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Paralysis", :cost => 30)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Sleep", :cost => 30)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Unconsciousness", :cost => 40)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Tipsy", :cost => 2)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Coughing", :cost => 4)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Moderate Pain", :cost => 4)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Euphoria", :cost => 6)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Nauseated", :cost => 6)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Severe Pain", :cost => 8)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Terrible Pain", :cost => 12)
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Altered Traits, Remove")
    (1..100).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => (pt*5-4).to_s + "-" + (pt*5).to_s + " points", :cost => pt, :include_notes_in_summary => true)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Altered Traits, Add")
    (1..500).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => (pt).to_s + " points", :cost => pt, :include_notes_in_summary => true)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Area of Effect")
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "3 yard radius", :cost => 2)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "5 yard radius", :cost => 4)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "7 yard radius", :cost => 6)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "10 yard radius", :cost => 8)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "15 yard radius", :cost => 10)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "20 yard radius", :cost => 12)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "30 yard radius", :cost => 14)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "50 yard radius", :cost => 16)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "70 yard radius", :cost => 18)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "100 yard radius", :cost => 20)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "150 yard radius", :cost => 22)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "200 yard radius", :cost => 24)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "300 yard radius", :cost => 26)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "500 yard radius", :cost => 28)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "700 yard radius", :cost => 30)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "1000 yard radius", :cost => 32)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "1500 yard radius", :cost => 34)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "2000 yard (1 mile) radius", :cost => 36)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "3000 yard radius", :cost => 38)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "5000 yard (2.5 miles) radius", :cost => 40)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "7000 yard radius", :cost => 42)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "10,000 yard (5 miles) radius", :cost => 44)
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Duration")
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "Momentary", :cost => 0)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "10 minutes", :cost => 1)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "30 minutes", :cost => 2)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "1 hour", :cost => 3)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "3 hours", :cost => 4)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "6 hours", :cost => 5)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "12 hours", :cost => 6)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "1 day", :cost => 7)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "3 days", :cost => 8)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "1 week", :cost => 9)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "2 weeks", :cost => 10)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "1 month", :cost => 11)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "2 months", :cost => 12)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "3 months", :cost => 13)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "4 months", :cost => 14)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "5 months", :cost => 15)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "6 months", :cost => 16)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "7 months", :cost => 17)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "8 months", :cost => 18)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "9 months", :cost => 19)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "10 months", :cost => 20)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "11 months", :cost => 21)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "1 year", :cost => 22)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "2 years", :cost => 23)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "3 years", :cost => 24)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "4 years", :cost => 25)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "5 years", :cost => 26)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "6 years", :cost => 27)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "7 years", :cost => 28)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "8 years", :cost => 29)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "9 years", :cost => 30)
    mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "10 years", :cost => 31)
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Extra Energy")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "+" + pt.to_s + " energy", :cost => pt)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Meta-Magic")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "+" + pt.to_s + " energy", :cost => pt)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Area of Effect, Excluded targets")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => (pt*2-1).to_s + "-" + (pt*2).to_s + " targets", :cost => pt)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Bestows a Broad Penalty")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "-" + pt.to_s, :include_notes_in_summary => true, :cost => (5*(2**(pt-1))))
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Bestows a Broad Bonus")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "+" + pt.to_s, :include_notes_in_summary => true, :cost => (5*(2**(pt-1))))
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Bestows a Moderate Penalty")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "-" + pt.to_s, :include_notes_in_summary => true, :cost => (2*(2**(pt-1))))
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Bestows a Moderate Bonus")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "+" + pt.to_s, :include_notes_in_summary => true, :cost => (2*(2**(pt-1))))
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Bestows a Narrow Penalty")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "-" + pt.to_s, :include_notes_in_summary => true, :cost => (2**(pt-1)))
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Bestows a Narrow Bonus")
    (1..10).each do |pt|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "+" + pt.to_s, :include_notes_in_summary => true, :cost => (2**(pt-1)))
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Damage, Internal")
    dice = (1..25).inject([]) { |memo, die| memo += ["#{die}d", "#{die}d+1", "#{die}d+2", "#{die+1}d-1"]; }
    dice.each_with_index do |die, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => die, :cost => index, :accepts_enhancements => true)
    end
    mod = add_damage_types(mod)
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Damage, External")
    dice = (1..25).inject([]) { |memo, die| memo += ["#{die*3}d", "#{die*3}d+3", "#{die*3}d+6", "#{3*die+1}d-3"]; }
    dice.each_with_index do |die, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => die, :cost => index, :accepts_enhancements => true)
    end
    mod = add_damage_types(mod)
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Damage, External Explosive")
    dice = (1..25).inject([]) { |memo, die| memo += ["#{die*2}d", "#{die*2}d+2", "#{die*2}d+4", "#{2*die+1}d-2"]; }
    dice.each_with_index do |die, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => die, :cost => index, :accepts_enhancements => true)
    end
    mod = add_damage_types(mod)
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Healing")
    dice = (1..25).inject([]) { |memo, die| memo += ["#{die}d", "#{die}d+1", "#{die}d+2", "#{die+1}d-1"]; }
    dice.each_with_index do |die, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => die, :cost => index)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Range")
    ["2 yards", "3 yards", "5 yards", "7 yards", "10 yards", "15 yards", "20 yards", "30 yards", "50 yards",
     "70 yards", "100 yards", "150 yards", "200 yards", "300 yards", "500 yards", "700 yards", "1000 yards",
     "1500 yards", "2000 yards (1 mile)", "3000 yards (1.5 miles)", "5000 yards (2.5 miles)", "7000 yards", "10,000 yards (5 miles)",
     "15,000 yards (7.5 miles)", "20,000 yards (10 miles)", "30,000 yards (15 miles)", "50,000 yards (25 miles)", "70,000 yards (35 miles)",
     "100,000 yards (50 miles)", "150,000 yards (75 miles)", "200,000 yards (100 miles)"].each_with_index do |dist, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => dist, :cost => index)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Range, Long-Distance")
    ["200 yards", "1/2 mile", "1 mile", "3 miles", "10 miles", "30 miles", "100 miles", "300 miles",
     "1000 miles", "3000 miles", "10,000 miles"].each_with_index do |dist, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => dist, :cost => index)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Range, Cross-Time")
    ["1/2 day", "1 day", "3 days", "10 days", "30 days (1 month)", "100 days (1 season)", "300 days (1 year)",
     "1000 days (3 years)", "3000 days (10 years)", "10,000 days (30 years)", "30,000 days (100 years)"].each_with_index do |desc, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => desc, :cost => index+1)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Range, Cross-Dimensional")
    (1..5).each do |index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => "#{index} dimensional barrier", :cost => (10*index))
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Speed")
    ["2 yards", "3 yards", "5 yards", "7 yards", "10 yards", "15 yards", "20 yards", "30 yards", "50 yards",
     "70 yards", "100 yards", "150 yards", "200 yards", "300 yards", "500 yards", "700 yards", "1000 yards",
     "1500 yards", "2000 yards (1 mile)", "3000 yards (1.5 miles)", "5000 yards (2.5 miles)", "7000 yards", "10,000 yards (5 miles)",
     "15,000 yards (7.5 miles)", "20,000 yards (10 miles)", "30,000 yards (15 miles)", "50,000 yards (25 miles)", "70,000 yards (35 miles)",
     "100,000 yards (50 miles)", "150,000 yards (75 miles)", "200,000 yards (100 miles)"].each_with_index do |desc, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => desc + " per second", :cost => index)
    end
    mod.save!

    mod = RpmModifier.new(:campaign_id => campaign_id, :name => "Subject Weight")
    ["10 lbs", "30 lbs", "100 lbs", "300 lbs", "1000 lbs", "3000 lbs", "5 tons", "15 tons", "50 tons",
     "150 tons", "450 tons", "1350 tons", "4050 tons", "12,150 tons", "36,450 tons", "109, 350 tons"].each_with_index do |dist, index|
      mod.rpm_modifier_levels << RpmModifierLevel.new(:description => dist, :cost => index)
    end
    mod.save!
  end

  def add_damage_types(mod)
    mod.rpm_modifier_subtypes << RpmModifierSubtype.new(:name => "Crushing", :multiplier => 1)
    mod.rpm_modifier_subtypes << RpmModifierSubtype.new(:name => "Small Piercing", :multiplier => 0.5)
    mod.rpm_modifier_subtypes << RpmModifierSubtype.new(:name => "Cutting", :multiplier => 1.5)
    mod.rpm_modifier_subtypes << RpmModifierSubtype.new(:name => "Large Piercing", :multiplier => 1.5)
    mod.rpm_modifier_subtypes << RpmModifierSubtype.new(:name => "Corrosion", :multiplier => 2)
    mod.rpm_modifier_subtypes << RpmModifierSubtype.new(:name => "Fatigue", :multiplier => 2)
    mod.rpm_modifier_subtypes << RpmModifierSubtype.new(:name => "Huge Piercing", :multiplier => 2)
    mod.rpm_modifier_subtypes << RpmModifierSubtype.new(:name => "Impaling", :multiplier => 2)
    mod
  end
end
