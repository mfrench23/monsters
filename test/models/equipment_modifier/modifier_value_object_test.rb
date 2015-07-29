require 'test_helper'

class ModifierValueObjectTest < ActiveSupport::TestCase
  setup do
  end

  test "parse Cost Factor" do
    one = EquipmentModifier::ModifierValueObject.get_instance("+1 CF")
    assert_equal 1, one.factor
    assert_equal 100, one.addition(100)
    assert_equal 50, one.addition(50)
    one = EquipmentModifier::ModifierValueObject.get_instance("+0.5 CF")
    assert_equal 1, one.factor
    assert_equal 50, one.addition(100)
    one = EquipmentModifier::ModifierValueObject.get_instance("-0.5 CF")
    assert_equal 1, one.factor
    assert_equal -50, one.addition(100)
  end

  test "parse addition" do
    one = EquipmentModifier::ModifierValueObject.get_instance("+$57.50")
    assert_equal 1, one.factor
    assert_equal 57.50, one.addition(100)
    assert_equal 57.50, one.addition(50)
    one = EquipmentModifier::ModifierValueObject.get_instance("+57.5 lbs")
    assert_equal 1, one.factor
    assert_equal 57.50, one.addition(100)
    one = EquipmentModifier::ModifierValueObject.get_instance("-$57.50")
    assert_equal 1, one.factor
    assert_equal -57.50, one.addition(100)
    one = EquipmentModifier::ModifierValueObject.get_instance("-57.50")
    assert_equal 1, one.factor
    assert_equal -57.50, one.addition(100)
  end

  test "parse multiplication" do
    one = EquipmentModifier::ModifierValueObject.get_instance("x3")
    assert_equal 3, one.factor
    assert_equal 0, one.addition(50)
    one = EquipmentModifier::ModifierValueObject.get_instance("*3")
    assert_equal 3, one.factor
    assert_equal 0, one.addition(100)
    one = EquipmentModifier::ModifierValueObject.get_instance("x 3")
    assert_equal 3, one.factor
    assert_equal 0, one.addition(100)
    one = EquipmentModifier::ModifierValueObject.get_instance("* 3")
    assert_equal 3, one.factor
    assert_equal 0, one.addition(50)
    one = EquipmentModifier::ModifierValueObject.get_instance("x3")
    assert_equal 3, one.factor
    assert_equal 0, one.addition(50)
    one = EquipmentModifier::ModifierValueObject.get_instance("*3.5")
    assert_equal 3.5, one.factor
    assert_equal 0, one.addition(100)
    one = EquipmentModifier::ModifierValueObject.get_instance("x3")
    assert_equal 3, one.factor
    assert_equal 0, one.addition(100)
    one = EquipmentModifier::ModifierValueObject.get_instance("*3/10")
    assert_equal 0.3, one.factor
    assert_equal 0, one.addition(100)
  end
end