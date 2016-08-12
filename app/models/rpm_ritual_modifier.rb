class RpmRitualModifier < ActiveRecord::Base
  belongs_to :rpm_ritual
  belongs_to :rpm_modifier_level

  has_one :rpm_modifier, :through => :rpm_modifier_level

  delegate :description, to: :rpm_modifier_level, prefix: true
  scope :inherent_only, -> { where(:inherent => true)}

  validates :rpm_ritual, presence: true
  validates :rpm_modifier_level, presence: true

  def to_short_s
    rpm_modifier.to_s
  end

  def to_long_s
    "#{to_short_s}, #{rpm_modifier_level_description}#{filtered_notes}#{enhancements} (#{cost})"
  end

  def cost
    rpm_modifier_level.cost + enhancement_addition
  end

  private

  def enhancement_addition
    return 0 unless rpm_modifier_level.accepts_enhancements && enhancement_percentage.to_i > 0
    return one_per_five_percent if rpm_modifier_level.cost <= 20
    apply_enhancement_percentage
  end

  def apply_enhancement_percentage
    ( rpm_modifier_level.cost.to_f * (enhancement_percentage.to_f/100) ).ceil
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
