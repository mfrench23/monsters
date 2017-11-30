# Details concerning a GURPS Skill posessed by a particular Creature (particularly, skill level)
class Skill < AbstractEntity
  belongs_to :monster, touch: true
  belongs_to :master_skill

  has_one :characteristic, :through => :master_skill

  validates :master_skill, presence: true
  validate :validate_specialization_if_required
  validate :validate_tech_level_if_required
  validate :validate_tech_level_if_forbidden

  delegate :notes, to: :master_skill, prefix: true
  delegate :name, to: :monster, prefix: true

  scope :order_by_monster_name, -> { includes(:monster).order("monsters.name") }
  scope :order_by_master_skill, -> { includes(:master_skill).order("master_skills.name") }

  def to_s
    master_skill.name + spec_to_s + tl_to_s + at_actual_phrase + (notes.blank? ? "" : " (#{notes})" )
  end

  def deep_copy
    copy = dup
    copy
  end

  private

  def at_actual_phrase
    mod = Modifier.new(modifier)
    actval = mod.actual( monster.try(:characteristic_score, characteristic) )
    " @#{characteristic.to_s}#{mod.to_s}#{actval}"
  end

  def spec_to_s
    (specialization.blank? ? nil : " (" + specialization + ")").to_s
  end

  def tl_to_s
    ( tech_level.blank? ? nil : "/TL#{tech_level}" ).to_s
  end

  def validate_tech_level_if_forbidden
    if (! master_skill.requires_tech_level) && (!tech_level.blank?)
      errors[:tech_level] << ": #{master_skill.name} may not have a TL"
    end
  end

  def validate_tech_level_if_required
    if master_skill.requires_tech_level && tech_level.blank?
      errors[:tech_level] << ": #{master_skill.name} requires TL"
    end
  end

  def validate_specialization_if_required
    if master_skill.requires_specialization && specialization.blank?
      errors[:specialization] << ": #{master_skill.name} requires specialization"
    end
  end
end
