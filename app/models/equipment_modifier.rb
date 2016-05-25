class EquipmentModifier < AbstractEntity
  belongs_to :equipment_modifier_category

  def modifier_value_object(symbol)
    return base_cost_modifier_value_object if :base_cost == symbol
    return cost_modifier_value_object if :cost == symbol
    return base_weight_modifier_value_object if :base_weight == symbol
    return weight_modifier_value_object if :weight == symbol
  end

  def to_s
    "#{name} (" + modifiers_to_s + notes_to_s + ")"
  end

  def base_cost_mod=(value)
    @base_cost_modifier_value_object = nil
    write_attribute(:base_cost_mod, value)
  end

  def cost_mod=(value)
    @cost_modifier_value_object = nil
    write_attribute(:cost_mod, value)
  end

  def base_weight_mod=(value)
    @base_weight_modifier_value_object = nil
    write_attribute(:base_weight_mod, value)
  end

  def weight_mod=(value)
    @weight_modifier_value_object = nil
    write_attribute(:weight_mod, value)
  end

  def deep_copy
    dup
  end

  private

  def notes_to_s
    return "; " + notes if notes.present?
    ""
  end

  def modifiers_to_s
    [base_cost_to_s, base_weight_to_s, cost_modifier_value_object.to_s, weight_to_s].reject{ |x| x.blank? }.join(", ")
  end

  def weight_to_s
     weight_modifier_value_object.to_s + " wt" if weight_mod.present?
  end

  def base_weight_to_s
    "base weight " + base_weight_modifier_value_object.to_s if base_weight_mod.present?
  end

  def base_cost_to_s
    "base cost " + base_cost_modifier_value_object.to_s if base_cost_mod.present?
  end

  def base_cost_modifier_value_object
    @base_cost_modifier_value_object ||= EquipmentModifier::ModifierValueObject.get_instance(base_cost_mod, true)
  end

  def cost_modifier_value_object
    @cost_modifier_value_object ||= EquipmentModifier::ModifierValueObject.get_instance(cost_mod, true)
  end

  def base_weight_modifier_value_object
    @base_weight_modifier_value_object ||= EquipmentModifier::ModifierValueObject.get_instance(base_weight_mod)
  end

  def weight_modifier_value_object
    @weight_modifier_value_object ||= EquipmentModifier::ModifierValueObject.get_instance(weight_mod)
  end
end
