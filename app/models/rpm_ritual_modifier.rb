class RpmRitualModifier < ActiveRecord::Base
  include LeveledModifier
  
  belongs_to :rpm_ritual, :touch => true
  belongs_to :rpm_modifier_level
  belongs_to :rpm_modifier_subtype
  has_one :rpm_modifier, :through => :rpm_modifier_level

  scope :inherent_only, -> { where(:inherent => true)}

  validates :rpm_modifier_level, presence: true

  def deep_copy
    dup
  end
end
