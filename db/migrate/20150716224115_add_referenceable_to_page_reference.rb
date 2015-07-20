class AddReferenceableToPageReference < ActiveRecord::Migration
  def change
    change_table :page_references do |t|
      t.references :referenceable, :polymorphic => true, :index => true
    end
    PageReference.update_all( "referenceable_id = monster_id, referenceable_type = 'Monster'")
  end
end
