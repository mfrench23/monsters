class RemoveNameAndDescriptionAndIsFeatureFromTrait < ActiveRecord::Migration
  def change
    remove_column :traits, :name, :string
    remove_column :traits, :description, :string
    remove_column :traits, :is_feature, :boolean
  end
end
