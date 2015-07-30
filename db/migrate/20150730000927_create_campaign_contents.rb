class CreateCampaignContents < ActiveRecord::Migration
  def change
    create_table :campaign_contents do |t|
      t.references :campaign, index: true
      t.references :content, polymorphic: true, index: true
      t.text :notes

      t.timestamps null: false
    end
    add_foreign_key :campaign_contents, :campaigns
  end
end
