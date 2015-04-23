class ExpandAttackDescriptionField < ActiveRecord::Migration
  def up
    change_column :attacks, :description, :text
  end

  def down
    add_column :attacks, :temp_description, :string
    Attack.find_each do |attack|
      temp_description = attack.description
      if attack.description.length > 255
        temp_description = attack.description[0,254]
      end
      Attack.update_column(:temp_description, temp_description)
    end
    remove_column :attacks, :description
    rename_column :attacks, :temp_description, :description
  end
end
