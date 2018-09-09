module LeveledModifier
  extend ActiveSupport::Concern

  def to_short_s
    "#{rpm_modifier.to_short_s}#{name_extension(false)}#{enhancement_only_text}"
  end

  def to_long_s
    "#{rpm_modifier.to_short_s}#{name_extension}#{enhancement_only_text} (#{cost})"
  end

  def cost
    base = (rpm_modifier_level.cost * subtype_factor).ceil
    enhancement_addition(base) + (rpm_modifier_level.accepts_enhancements && enhancement_only ? 0 : base)
  end

  private

  def enhancement_only_text
    ", enhancement only" if rpm_modifier_level.accepts_enhancements && enhancement_only
  end

  def name_extension(with_level=true)
    ", #{name_extension_text(with_level)}" unless name_extension_text(with_level).blank?
  end

  def name_extension_text(with_level)
    "#{rpm_modifier_subtype_name}#{rpm_modifier_level_description(with_level)}#{filtered_notes}#{enhancements}"
  end

  def rpm_modifier_subtype_name
    "#{rpm_modifier_subtype.name}" unless rpm_modifier_subtype.blank?
  end

  def rpm_modifier_level_description(with_level)
    return " #{rpm_modifier_level.description}" unless rpm_modifier.exclude_level_from_summary || (! with_level)
  end

  def filtered_notes
    " #{notes}" if rpm_modifier_level.include_notes_in_summary && notes.present?
  end

  def enhancements
    " (#{enhancement_notes})" if rpm_modifier_level.accepts_enhancements && enhancement_notes.present?
  end

  def subtype_factor
    return 1 unless rpm_modifier_subtype.present?
    rpm_modifier_subtype.multiplier
  end 

  def enhancement_addition(base)
    return 0 unless rpm_modifier_level.accepts_enhancements && enhancement_percentage.present?
    return one_per_five_percent if base <= 20
    apply_enhancement_percentage(base)
  end

  def apply_enhancement_percentage(base)
    [1, ( base.to_f * (enhancement_percentage.to_f/100) ).ceil].max
  end

  def one_per_five_percent
    [ 1, (enhancement_percentage.to_f/5).ceil ].max
  end
end 