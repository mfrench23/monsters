class CreateSwarms < ActiveRecord::Migration
  def change
    create_table :swarms do |t|
      t.text :number_description

      t.timestamps null: false
    end
  end
end
