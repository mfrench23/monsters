class Skill < ActiveRecord::Base
  belongs_to :monster
  belongs_to :master_skill

  has_one :characteristic, :through => :master_skill

  validates :master_skill, presence: true
  validate :validate_has_modifier_or_actual
  validate :validate_has_required_specialization

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
    spec = (specialization.to_s.empty? ? nil : " (" + specialization + ")")
    master_skill.name + spec.to_s + at_sym.to_s + (actval.nil? ? "" : eq_sym.to_s + actval.to_s )
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

  def validate_has_modifier_or_actual
    if actual.blank? && modifier.blank?
      errors[:modifier] << "Either 'modifier' or 'actual' must be populated"
    end
  end

  def validate_has_required_specialization
    #if master_skill.requires_specialization && specialization.blank?
    if master_skill.requires_specialization && specialization.blank?
      errors[:specialization] << "#{master_skill.name} requires specialization"
    end
  end
end
