class EquipmentModifier::ModifierValueObject
  def self.get_instance(text, is_money = false)
    s = convert_fractions(text.to_s.strip)
    get_cost_factor_modifier_value_object(s, is_money) || get_additive_modifier_value_object(s, is_money) || get_multiplicative_modifier_value_object(s) || EquipmentModifier::NoOpModifierValueObject.new
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
    if m = s.match( Regex_Multiplicative_Modifier )
      EquipmentModifier::MultiplierModifierValueObject.new(m[:num])
    end
  end

  def self.get_additive_modifier_value_object(s, is_money)
    if m = s.match( Regex_Additive_Modifier )
      EquipmentModifier::AdditiveModifierValueObject.new(m[:pm], m[:num], is_money)
    end
  end

  def self.get_cost_factor_modifier_value_object(s, is_money)
    if m = s.match( Regex_Cost_Factor_Modifier )
      EquipmentModifier::CostFactorModifierValueObject.new(m[:pm], m[:num], is_money)
    end
  end

  def self.convert_fractions(text)
    if m = text.match(/(?<a>#{Regex_Number})\/(?<b>#{Regex_Number})/)
      a = m[:a].to_d
      b = m[:b].to_d
      text.gsub(/#{m[:a]}\/#{m[:b]}/, (a/b).to_s)
    else
      text
    end
  end
end
