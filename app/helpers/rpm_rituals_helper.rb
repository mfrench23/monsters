module RpmRitualsHelper
  def long_ritual_link(ritual)
    popup = rpm_inherent_elements_text ritual, ", "
    popup = [popup, ritual.description].join("\n\n")
    link_to ritual, ritual, :class => "quiet", :title => popup
  end

  def rpm_inherent_elements_text(rpm_ritual, join_text = " + " )
    [ rpm_inherent_spell_effects_text(rpm_ritual, join_text), rpm_inherent_spell_modifiers_text(rpm_ritual, join_text) ].select{|txt| txt.present? }.join( join_text )
  end

  def rpm_inherent_spell_effects_text(rpm_ritual, join_text = " + ")
    inherent_mods = rpm_ritual.rpm_spell_effects.inherent_only
    text_for inherent_mods, join_text
  end

  def rpm_inherent_spell_modifiers_text(rpm_ritual, join_text = " + ")
    inherent_mods = rpm_ritual.rpm_ritual_modifiers.inherent_only
    text_for inherent_mods, join_text
  end

  private

  def text_for(mods, join_text)
    return "" unless mods.any?
    collapse_like_effects(mods).join(join_text)
  end

  def collapse_like_effects(arr)
    memo = []
    counter = 0
    arr.collect(&:to_short_s).sort.each { |val| counter = assimilate_val memo, val, counter }
    multiply_previous_effect memo, counter
  end

  def assimilate_val(memo, val, counter)
    return counter+1 unless new_val(memo, val)
    multiply_previous_effect memo, counter
    memo << val
    return 1
  end

  def new_val(memo, val)
    memo.empty? || memo[-1] != val
  end

  def multiply_previous_effect(memo, counter)
    memo[-1] = format_effect(memo[-1], counter ) if counter > 1
    memo
  end

  def format_effect(text, counter)
    text if counter <= 1
    "#{text} x#{counter}"
  end
end
