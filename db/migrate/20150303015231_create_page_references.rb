class CreatePageReferences < ActiveRecord::Migration
  def change
    create_table :page_references do |t|
      t.references :book, index: true
      t.references :monster, index: true
      t.string :pages

      t.timestamps null: false
    end
  end
end
