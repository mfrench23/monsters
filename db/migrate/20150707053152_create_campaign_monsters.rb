class CreateCampaignMonsters < ActiveRecord::Migration
  def change
    create_table :campaign_monsters do |t|
      t.references :campaign, index: true
      t.references :monster, index: true

      t.timestamps null: false
    end
    add_foreign_key :campaign_monsters, :campaigns
    add_foreign_key :campaign_monsters, :monsters
    add_index :campaign_monsters, ["campaign_id", "monster_id"], name: "index_campaign_monsters_on_campaign_id_and_monster_id", using: :btree, unique: true
    add_index :campaign_monsters, ["monster_id", "campaign_id"], name: "index_campaign_monsters_on_monster_id_and_campaign_id", using: :btree, unique: true
  end
end
