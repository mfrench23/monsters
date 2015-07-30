class DropCampaignMonsters < ActiveRecord::Migration
  class CampaignContent < ActiveRecord::Base
  end

  class CampaignMonster < ActiveRecord::Base
  end

  def up
    drop_table :campaign_monsters
  end

  def down
    create_table "campaign_monsters", force: :cascade do |t|
      t.integer  "campaign_id", limit: 4
      t.integer  "monster_id",  limit: 4
      t.datetime "created_at",            null: false
      t.datetime "updated_at",            null: false
    end

    add_index "campaign_monsters", ["campaign_id", "monster_id"], name: "index_campaign_monsters_on_campaign_id_and_monster_id", unique: true, using: :btree
    add_index "campaign_monsters", ["campaign_id"], name: "index_campaign_monsters_on_campaign_id", using: :btree
    add_index "campaign_monsters", ["monster_id", "campaign_id"], name: "index_campaign_monsters_on_monster_id_and_campaign_id", unique: true, using: :btree
    add_index "campaign_monsters", ["monster_id"], name: "index_campaign_monsters_on_monster_id", using: :btree

    add_foreign_key "campaign_monsters", "campaigns"
    add_foreign_key "campaign_monsters", "monsters"


    CampaignContent.where(:content_type => 'Monster').each do |campaign_content|
      campaign_monster = CampaignMonster.new({:campaign_id => campaign_content.campaign_id,
                                              :monster_id => campaign_content.content_id })
      campaign_monster.save
    end
  end
end
