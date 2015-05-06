class IndexCharacteristicNameAndSequenceNumber < ActiveRecord::Migration
  def up
    add_index :characteristics, :name, unique: true
    add_index :characteristics, :sequence_number, unique: true
  end

  def down
    remove_index :characteristics, :name
    remove_index :characteristics, :sequence_number
  end
end
