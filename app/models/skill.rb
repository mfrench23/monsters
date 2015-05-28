class Skill < ActiveRecord::Base
  belongs_to :creature
  belongs_to :master_skill

  has_one :characteristic, :through => :master_skill

  validates :master_skill, presence: true
  validate :validate_has_modifier_or_actual
  validate :validate_has_required

  def to_s
    if(modifier)
      mod = Modifier.new(modifier)
      actval = mod.actual( creature.try(:characteristic_score, characteristic) )
      at_sym = " @" + characteristic.to_s + mod.to_s
      eq_sym = "="
    else
      actval = actual
      at_sym = nil
      eq_sym = "-"
    end
    master_skill.name + spec_to_s + tl_to_s + at_sym.to_s + (actval.nil? ? "" : eq_sym.to_s + actval.to_s ) + (notes.to_s.empty? ? "" : " (#{notes})" )
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

  def spec_to_s
    (specialization.to_s.empty? ? nil : " (" + specialization + ")").to_s
  end

  def tl_to_s
    ( tech_level.to_s.empty? ? nil : "/TL#{tech_level}" ).to_s
  end

  def validate_has_modifier_or_actual
    if actual.blank? && modifier.blank?
      errors[:modifier] << ": Either 'modifier' or 'actual' must be populated"
    end
  end

  def validate_has_required
    if master_skill.requires_specialization && specialization.blank?
      errors[:specialization] << ": #{master_skill.name} requires specialization"
    end
    if master_skill.requires_tech_level && tech_level.blank?
      errors[:tech_level] << ": #{master_skill.name} requires TL"
    end
    if (! master_skill.requires_tech_level) && (!tech_level.blank?)
      errors[:tech_level] << ": #{master_skill.name} may not have a TL"
    end
  end
end
