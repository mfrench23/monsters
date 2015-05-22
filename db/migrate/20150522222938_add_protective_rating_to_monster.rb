class AddProtectiveRatingToMonster < ActiveRecord::Migration
  def change
    add_column :monsters, :protective_rating, :integer
  end
end
