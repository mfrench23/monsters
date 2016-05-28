# Represents a value object that can perform certain modifications on the value it is 
# attached to; for example, a "x2" modifier would multiply the value it modifies by 2.
class EquipmentModifier::ModifierValueObject
  def self.get_instance(text, is_money = false)
    txt = convert_fractions(text.to_s.strip)
    get_cost_factor_modifier_value_object(txt, is_money) || get_additive_modifier_value_object(txt, is_money) || get_multiplicative_modifier_value_object(txt) || EquipmentModifier::NoOpModifierValueObject.new
  end

  private

  Regex_Cost_Factor = /[cC][fF]/
  Regex_Number = /[\d.]+/
  Regex_Money = //
  Regex_PlusOrMinus = /[+-]/
  Regex_Multiplier = /[*x]/

  Regex_Cost_Factor_Modifier = /^(?<pm>#{Regex_PlusOrMinus}) *(?<num>#{Regex_Number}) *#{Regex_Cost_Factor}$/
  Regex_Additive_Modifier = /^(?<pm>#{Regex_PlusOrMinus})[^\d]*(?<num>#{Regex_Number})[^\d]*$/
  Regex_Multiplicative_Modifier = /^#{Regex_Multiplier} *(?<num>#{Regex_Number})$/

  def self.get_multiplicative_modifier_value_object(s)
    if match = s.match( Regex_Multiplicative_Modifier )
      EquipmentModifier::MultiplierModifierValueObject.new(match[:num])
    end
  end

  def self.get_additive_modifier_value_object(text, is_money)
    if match = text.match( Regex_Additive_Modifier )
      EquipmentModifier::AdditiveModifierValueObject.new(match[:pm], match[:num], is_money)
    end
  end

  def self.get_cost_factor_modifier_value_object(text, is_money)
    if match = text.match( Regex_Cost_Factor_Modifier )
      EquipmentModifier::CostFactorModifierValueObject.new(match[:pm], match[:num], is_money)
    end
  end

  def self.convert_fractions(text)
    if match = text.match(/(?<a>#{Regex_Number})\/(?<b>#{Regex_Number})/)
      numerator, denominator = match[:a], match[:b]
      text.gsub(/#{numerator}\/#{denominator}/, (numerator.to_d/denominator.to_d).to_s)
    else
      text
    end
  end
end
