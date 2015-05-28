class CreatureActsAsMonster < ActiveRecord::Migration
  def change
    change_table :monsters do |t|
      t.actable
    end
  end
end
