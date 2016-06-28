class DropTableCampaignContents < ActiveRecord::Migration
  def up
    drop_table :campaign_contents
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
