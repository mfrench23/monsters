class AddPartsValueToMonster < ActiveRecord::Migration
  def change
    add_money :monsters, :parts_value, currency: {present: false}, amount: {null: true, default: nil}
  end
end
