class AddNotesToTrait < ActiveRecord::Migration
  def change
    add_column :traits, :notes, :text
  end
  #
  # MasterTrait.where("notes is not null").each do |master|
  #   master.traits.each do |trait|
  #     trait.notes = master.notes
  #     trait.save
  #   end
  # end
  #
end
