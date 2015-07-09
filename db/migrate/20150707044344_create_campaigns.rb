class CreateCampaigns < ActiveRecord::Migration
  class Campaign < ActiveRecord::Base
  end

  def change
    create_table :campaigns do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :campaigns, :name, unique: true
  end
end
