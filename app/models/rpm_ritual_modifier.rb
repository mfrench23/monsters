class RpmRitualModifier < ActiveRecord::Base
  belongs_to :rpm_ritual
  belongs_to :rpm_modifier_level
  belongs_to :rpm_modifier_subtype
  has_one :rpm_modifier, :through => :rpm_modifier_level

  delegate :description, to: :rpm_modifier_level, prefix: true
  delegate :name, to: :rpm_modifier_subtype, prefix: true, allow_nil: true
  scope :inherent_only, -> { where(:inherent => true)}

  validates :rpm_ritual, presence: true
  validates :rpm_modifier_level, presence: true

  def to_short_s
    rpm_modifier.to_s
  end

  def to_long_s
    "#{to_short_s} #{rpm_modifier_subtype_name} #{rpm_modifier_level_description}#{filtered_notes}#{enhancements} (#{cost})"
  end

  def cost
    base = (rpm_modifier_level.cost * subtype_factor).ceil
    base + enhancement_addition(base)
  end

  private

  def subtype_factor
    return 1 unless rpm_modifier_subtype.present?
    rpm_modifier_subtype.multiplier
  end

  def enhancement_addition(base)
    return 0 unless rpm_modifier_level.accepts_enhancements && enhancement_percentage.to_i > 0
    return one_per_five_percent if base <= 20
    apply_enhancement_percentage(base)
  end

  def apply_enhancement_percentage(base)
    ( base.to_f * (enhancement_percentage.to_f/100) ).ceil
  end

  def one_per_five_percent
    [ 1, (enhancement_percentage.to_f/5).ceil ].max
  end

  def filtered_notes
    notes if rpm_modifier_level.include_notes_in_summary
  end

  def enhancements
    " (#{enhancement_notes})" if rpm_modifier_level.accepts_enhancements && enhancement_notes.present?
  end
end
