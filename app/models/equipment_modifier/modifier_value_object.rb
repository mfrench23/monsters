class EquipmentModifier::ModifierValueObject
  def self.get_instance(text, is_money = false)
    s = convert_fractions(text.to_s.strip)
    if m = s.match( /^(?<pm>#{Regex_PlusOrMinus}) *(?<num>#{Regex_Number}) *#{Regex_Cost_Factor}$/ )
      CostFactorModifierValueObject.new(m[:pm], m[:num], is_money)
    elsif m = s.match( /^(?<pm>#{Regex_PlusOrMinus})[^\d]*(?<num>#{Regex_Number})[^\d]*$/ )
      AdditiveModifierValueObject.new(m[:pm], m[:num], is_money)
    elsif m = s.match( /^#{Regex_Multiplier} *(?<num>#{Regex_Number})$/ )
      MultiplierModifierValueObject.new(m[:num])
    else
      NoOpModifierValueObject.new
    end
  end

  private

  Regex_Cost_Factor = /[cC][fF]/
  Regex_Number = /[\d.]+/
  Regex_Money = //
  Regex_PlusOrMinus = /[+-]/
  Regex_Multiplier = /[*x]/

  def self.convert_fractions(text)
    if m = text.match(/(?<a>#{Regex_Number})\/(?<b>#{Regex_Number})/)
      a = m[:a].to_d
      b = m[:b].to_d
      text.gsub(/#{m[:a]}\/#{m[:b]}/, (a/b).to_s)
    else
      text
    end
  end

  class NoOpModifierValueObject < EquipmentModifier::ModifierValueObject
    def addition(base)
      return 0
    end
    def factor
      return 1
    end
  end

  class MultiplierModifierValueObject < EquipmentModifier::ModifierValueObject
    def initialize( num )
      @val = num.to_d
    end
    def addition(base)
      return 0
    end
    def factor
      return @val
    end
    def to_s
      "x%g" % @val
    end
  end

  class AdditiveModifierValueObject < EquipmentModifier::ModifierValueObject
    def initialize( plus_or_minus, num, is_money )
      @is_money = is_money
      @sign = ( plus_or_minus == "-" ? -1 : 1 )
      @val = ( is_money ? Money.new(num.to_d * 100) : num.to_d )
    end
    def addition(base)
      return @val * @sign
    end
    def factor
      return 1
    end
    def to_s
      (@sign > 0 ? "+" : "-") + (@is_money ? @val.format : "%g" % @val + "#")
    end
  end

  class CostFactorModifierValueObject < EquipmentModifier::ModifierValueObject
    def initialize( plus_or_minus, num, is_money )
      @is_money = is_money
      @sign = ( plus_or_minus == "-" ? -1 : 1 )
      @val = num.to_d
    end
    def addition(base)
      return base * @val * @sign
    end
    def factor
      return 1
    end
    def to_s
      (@sign > 0 ? "+" : "-") + ("%g" % @val) + " CF"
    end
  end
end
