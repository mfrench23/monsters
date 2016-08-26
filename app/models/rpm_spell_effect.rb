class RpmSpellEffect < AbstractEntity
  belongs_to :rpm_ritual, :touch => true
  belongs_to :rpm_potency
  belongs_to :rpm_effect
  belongs_to :rpm_path

  delegate :cost_factor, to: :rpm_potency, prefix: true
  delegate :cost, to: :rpm_effect, prefix: false
  delegate :inherent_cost, to: :rpm_ritual, prefix: true
  delegate :typical_cost, to: :rpm_ritual, prefix: true

  scope :inherent_only, -> (optional_ignored_param = nil) { where(:inherent => true)}
  scope :greater_effect, -> { joins(:rpm_potency).where("rpm_potencies.cost_factor > 0") }
  scope :sorted, -> { joins([:rpm_potency, :rpm_effect, :rpm_path]).order("rpm_potencies.name, rpm_effects.name, rpm_paths.name") }
  scope :with_potency, -> (potency_id) { where(:rpm_potency_id => potency_id) }
  scope :with_effect, -> (effect_id) { where(:rpm_effect_id => effect_id) }
  scope :with_path, -> (path_id) { where(:rpm_path_id => path_id) }

  def to_short_s
    rpm_potency.to_s + " " + rpm_effect.to_s + " " + rpm_path.to_s
  end

  def to_long_s
    "#{to_short_s} (#{cost})"
  end

  def self.default_index_sort
    "rpm_potencies.cost_factor, rpm_effects.cost, rpm_paths.name, rpm_rituals.name"
  end
end
