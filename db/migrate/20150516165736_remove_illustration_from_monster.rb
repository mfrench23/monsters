class RemoveIllustrationFromMonster < ActiveRecord::Migration
  def self.up
    remove_attachment :monsters, :illustration
  end

  def self.down
    change_table :monsters do |t|
      t.attachment :illustration
    end
  end
end
