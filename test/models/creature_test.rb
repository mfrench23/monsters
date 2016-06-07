require 'test_helper'

class CreatureTest < ActiveSupport::TestCase
  setup do
    dx = Characteristic.find_by(name: "DX")
    @one = Creature.new(:name => "Boris the Test Monster", :monster_class => MonsterClass.find_by(name: "Undead"),
                        :characteristic_monsters => [CharacteristicMonster.new(:characteristic => dx, :score => 10)] )
  end

  test "freeform_trait_list adds to master traits - one trait with level and notes" do
    name = "Bogotrait (Disintegration) 3"
    assert_difference "MasterTrait.count" do
      @one.freeform_trait_list = name
    end
    mt = MasterTrait.find_by(:name => "Bogotrait")
    assert_equal false, mt.name.blank?
    assert_nil mt.notes
    trait = @one.traits.first
    assert_equal mt, trait.master_trait
    assert_equal "3", trait.level.to_s
    assert_equal "Disintegration", trait.notes
  end

  test "freeform_trait_list adds to master traits - 2 traits, one complex" do
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (with) 3; Further Arglebargle"
    end
  end

  test "freeform_trait_list adds to master traits - 2 traits, one complex, delim by comma" do
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (with) 3, Further Arglebargle"
    end
    assert_equal 3, @one.traits.first.level
  end

  test "freeform_trait_list adds to master traits - 2 traits, one with semicolons inside parens and a trailing period" do
    assert_difference "MasterTrait.count", 2 do
      @one.freeform_trait_list="Arglebargle (Dungeon; Urban; Mountain); Exceptional Arglebargle 1."
    end
    assert_equal "Arglebargle", @one.traits.first.master_trait.name
  end

  test "new creature starts with basic characteristics" do
    m = Creature.new
    assert_not_nil m.characteristic_monster("DX")
    assert_nil m.characteristic_monster("Fake Characteristic")
    assert_equal 10, m.characteristic_score("DX")
  end

  test "can deep_copy" do
    # set up original
    equipment_type = FactoryGirl.create(:equipment_type)
    equipment_package = EquipmentPackage.new
    equipment_package.equipment_pieces << EquipmentPiece.new(:equipment_type => equipment_type,
                                                             :quantity => 1,
                                                             :equipment_modifiers => [EquipmentModifier.new(:name => "Heavy", :weight_mod => "x1.1")])
    @one.skills << Skill.new(:master_skill => MasterSkill.find_by(:name => "Brawling"), :modifier => 1 )
    @one.skills << Skill.new(:master_skill => MasterSkill.find_by(:name => "Stealth"), :modifier => 0 )
    @one.traits << Trait.new(:master_trait => MasterTrait.new( :name => "Combat Reflexes" ) )
    @one.damage_resistances << DamageResistance.new(dr: 2, location: Location.first)
    @one.parry_scores << ParryScore.new(weapon: "Brawling", parry: 11)
    @one.page_references << PageReference.new(book: Book.first, pages: "37-38")
    @one.attacks << Attack.new(description: "3d cr")
    @one.movement_rates << MovementRate.new(move_type: MoveType.first, rate: 3)
    @one.notes = "These are notes."
    @one.description = "This is a description."
    @one.equipment_packages << equipment_package
    assert_equal true, @one.save
    assert_equal 10, @one.characteristic_monsters.first.score
    assert_equal "Brawling", @one.skills.first.master_skill.name
    assert_equal Money.new(1000), @one.equipment_packages.first.equipment_pieces.first.cost
    assert_equal "10.00", @one.equipment_packages.first.equipment_pieces.first.cost.to_s

    # create the copy and modify it
    copy = @one.deep_copy
    assert_equal "Copy of " + @one.name, copy.to_s
    assert_equal "DX", copy.characteristic_monsters.first.characteristic.to_s
    copy.characteristic_monsters.first.score = 20
    assert_equal 20, (copy.characteristic_score "DX")
    copy.parry_scores.first.weapon = "Kung Fu"
    copy.traits.first.level = 2
    copy.equipment_packages.first.equipment_pieces.first.equipment_modifiers << EquipmentModifier.new(:name => "Superfly", :cost_mod => "+$15")
    assert_equal "25.00", copy.equipment_packages.first.equipment_pieces.first.cost.to_s
    assert_no_difference('MasterSkill.count', 'Not expecting a new MasterSkill to be created') do
      copy.skills.first.modifier = 2
      assert_equal "Brawling @DX+2=12", copy.skills.first.to_s
      copy.save!
    end
    assert_equal "Brawling", copy.skills.first.master_skill.name
    assert_equal @one, copy.parent.specific
    assert_nil copy.notes
    assert_nil copy.description

    # load the original, make sure changes to copy didn't copy back to it
    one_loaded = Creature.find(@one.id)
    assert_equal 10, (one_loaded.characteristic_score "DX")
    assert_equal "Brawling @DX+1=11", one_loaded.skills.first.to_s
    assert_equal "Brawling", one_loaded.parry_scores.first.weapon
    assert_nil one_loaded.traits.first.level
    assert_equal 10, one_loaded.equipment_packages.first.equipment_pieces.first.cost
  end
end
