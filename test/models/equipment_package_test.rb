require 'test_helper'

class EquipmentPackageTest < ActiveSupport::TestCase
  test "final owner default behavior" do
    mock = MockOwner.new
    assert_equal mock, mock.final_owner
  end

  test "final owner overriden" do
    creature = FactoryBot.create(:creature)
    ep = EquipmentPackage.new(:name => "Package #1")
    creature.equipment_packages << ep
    assert_equal creature, ep.final_owner
  end

  test "can build equipment" do
    assert_not_nil EquipmentPackage.new.build_equipment_piece
  end

end

class MockOwner < Creature
  include EquipmentOwning
end