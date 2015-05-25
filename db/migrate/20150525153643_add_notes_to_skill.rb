class AddNotesToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :notes, :text
  end
end
