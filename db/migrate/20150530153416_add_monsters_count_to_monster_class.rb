class AddMonstersCountToMonsterClass < ActiveRecord::Migration
  def change
    add_column :monster_classes, :monsters_count, :integer
    # populate initial values, if any
    MonsterClass.find_each { |mc| MonsterClass.reset_counters(mc.id, :monsters) }
  end
end
