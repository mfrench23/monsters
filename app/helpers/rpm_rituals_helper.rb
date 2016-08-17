module RpmRitualsHelper
  def rpm_inherent_spell_effects_text(rpm_ritual)
    collapse_like_effects(rpm_ritual.rpm_spell_effects.inherent_only.collect(&:to_short_s)).join(" + ")
  end

  private

  def collapse_like_effects(arr)
    memo = []
    counter = 0
    arr.sort.each do |val|
      if memo.empty? || memo[-1] != val
        if counter > 1
          memo[-1] = format_effect(memo[-1], counter )
        end
        memo << val
        counter = 1
      else # if memo is not empty, and the last entry is the same as the current one
        counter += 1
      end
    end
    if counter > 1
      memo[-1] = format_effect(memo[-1], counter )
    end
    memo
  end

  def format_effect(text, counter)
    text if counter <= 1
    "#{text} x#{counter}"
  end
end
