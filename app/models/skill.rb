class Skill < ActiveRecord::Base
  belongs_to :monster
  belongs_to :master_skill

  has_one :characteristic, :through => :master_skill

  validates :master_skill, presence: true
  validate :has_modifier_or_actual

  def to_s
    if(modifier)
      mod = Modifier.new(modifier)
      actval = mod.actual( monster.try(:characteristic_score, characteristic) )
      at_sym = " @" + characteristic.to_s + mod.to_s
      eq_sym = "="
    else
      actval = actual
      at_sym = nil
      eq_sym = "-"
    end
    master_skill.name + at_sym.to_s + (actval.nil? ? "" : eq_sym.to_s + actval.to_s )
  end

  def actual
    @actual
  end

  def actual=(value)
    @actual = value
  end

  def convert_actual_to_modifier(monster_score)
    self.modifier = self.modifier || calc_modifier(monster_score)
  end

  private

  def calc_modifier(monster_score)
    self.actual.to_i - monster_score.to_i
  end

  def has_modifier_or_actual
    if actual.blank? && modifier.blank?
      errors[:modifier] << "Either 'modifier' or 'actual' must be populated"
    end
  end
end
