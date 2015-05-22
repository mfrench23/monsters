class RemoveOffensiveRatingAndProtectiveRatingFromMonster < ActiveRecord::Migration
  def change
    remove_column :monsters, :offensive_rating, :integer
    remove_column :monsters, :protective_rating, :integer
  end
end
