class UpdateMasterSkillToCharacteristics < ActiveRecord::Migration
  def up
    # ST: 1, DX: 2, IQ: 3, HT: 4, Will: 5, Per: 6
    st = Characteristic.new(:name => 'ST', :sequence_number => 1).save
    Characteristic.new(:name => 'DX', :sequence_number => 2).save
    Characteristic.new(:name => 'IQ', :sequence_number => 3).save
    Characteristic.new(:name => 'HT', :sequence_number => 4).save
    Characteristic.new(:name => 'Will', :sequence_number => 5).save
    Characteristic.new(:name => 'Per', :sequence_number => 6).save

    execute "update master_skills set characteristic_id = baseStat"
  end

  def down
    execute "update master_skills set baseStat = characteristic_id where characteristic_id <= 6"
    Characteristic.where(name: 'ST').destroy
    Characteristic.where(name: 'DX').destroy
    Characteristic.where(name: 'IQ').destroy
    Characteristic.where(name: 'HT').destroy
    Characteristic.where(name: 'Will').destroy
    Characteristic.where(name: 'Per').destroy
  end
end
