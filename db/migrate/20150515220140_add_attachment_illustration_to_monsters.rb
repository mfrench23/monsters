class AddAttachmentIllustrationToMonsters < ActiveRecord::Migration
  def self.up
    change_table :monsters do |t|
      t.attachment :illustration
    end
  end

  def self.down
    remove_attachment :monsters, :illustration
  end
end
