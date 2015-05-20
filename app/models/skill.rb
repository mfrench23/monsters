class Skill < ActiveRecord::Base
  belongs_to :monster
  belongs_to :master_skill

  has_one :characteristic, :through => :master_skill

  validates :master_skill, presence: true
  validates_with ActualOrModifierValidator

  def to_s
    mod = Modifier.new(modifier)
    actual = mod.actual( monster.try(:characteristic_score, characteristic) )
    master_skill.name + " @" + characteristic.to_s + mod.to_s + (actual.nil? ? "" : "=" + actual.to_s )
  end

  def actual
    @actual
  end

  def actual=(value)
    @actual = value.to_i
  end

  def convert_actual_to_modifier(monster_score)
    self.modifier = self.modifier || calc_modifier(monster_score)
  end

  private

  def calc_modifier(monster_score)
    self.actual - monster_score.to_i
  end
end
