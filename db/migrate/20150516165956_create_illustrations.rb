class CreateIllustrations < ActiveRecord::Migration
  def change
    create_table :illustrations do |t|

      t.references :illustratable, polymorphic: true, index: true
      t.text       :notes, limit: 65535
      t.timestamps null: false
    end
  end
end
