class RpmSpellEffect < ActiveRecord::Base
  belongs_to :rpm_ritual, :touch => true
  belongs_to :rpm_potency
  belongs_to :rpm_effect
  belongs_to :rpm_path

  delegate :cost_factor, to: :rpm_potency, prefix: true
  delegate :cost, to: :rpm_effect, prefix: false

  scope :inherent_only, -> { where(:inherent => true)}
  scope :greater_effect, -> { joins(:rpm_potency).where("rpm_potencies.cost_factor > 0") }

  def to_short_s
    rpm_potency.to_s + " " + rpm_effect.to_s + " " + rpm_path.to_s
  end

  def to_long_s
    "#{to_short_s} (#{cost})"
  end
end
