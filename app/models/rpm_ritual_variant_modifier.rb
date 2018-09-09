class RpmRitualVariantModifier < ApplicationRecord
  include LeveledModifier

  has_one :rpm_modifier, :through => :rpm_modifier_level

  belongs_to :rpm_ritual_variant
  belongs_to :rpm_modifier_level
  belongs_to :rpm_modifier_subtype

  def deep_copy
    dup
  end
end
