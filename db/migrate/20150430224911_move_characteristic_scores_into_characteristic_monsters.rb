class MoveCharacteristicScoresIntoCharacteristicMonsters < ActiveRecord::Migration
  def up
    Characteristic.new(:name => 'HP').save
    Characteristic.new(:name => 'Fatigue').save
    Characteristic.new(:name => 'SM').save
    
    Monster.find_each do |m|
      c = Characteristic.find_by(name: 'ST')
      m.characteristic_monsters.create(characteristic: c, score: m.strength)
      c = Characteristic.find_by(name: 'DX')
      m.characteristic_monsters.create(characteristic: c, score: m.dexterity)
      c = Characteristic.find_by(name: 'IQ')
      m.characteristic_monsters.create(characteristic: c, score: m.intelligence)
      c = Characteristic.find_by(name: 'HT')
      m.characteristic_monsters.create(characteristic: c, score: m.health)
      c = Characteristic.find_by(name: 'HP')
      m.characteristic_monsters.create(characteristic: c, score: m.hitPoints)
      c = Characteristic.find_by(name: 'Will')
      m.characteristic_monsters.create(characteristic: c, score: m.will)
      c = Characteristic.find_by(name: 'Per')
      m.characteristic_monsters.create(characteristic: c, score: m.perception)
      c = Characteristic.find_by(name: 'Fatigue')
      m.characteristic_monsters.create(characteristic: c, score: m.fatigue)
      c = Characteristic.find_by(name: 'SM')
      m.characteristic_monsters.create(characteristic: c, score: m.sizeModifier)
    end
  end
  
  def down
    Monster.find_each do |m|
      m.characteristic_monsters.clear
    end
    
    Characteristic.find_by(name: 'Fatigue').delete
    Characteristic.find_by(name: 'HP').delete
  end
end
