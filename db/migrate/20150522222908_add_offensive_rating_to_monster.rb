class AddOffensiveRatingToMonster < ActiveRecord::Migration
  def change
    add_column :monsters, :offensive_rating, :integer
  end
end
