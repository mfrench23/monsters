class AddMonsterIdToParryScores < ActiveRecord::Migration
  def change
    add_reference :parry_scores, :monster, index: true
    add_foreign_key :parry_scores, :monsters
  end
end
