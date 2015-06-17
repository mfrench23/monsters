class RemoveIsFeatureFromMasterTrait < ActiveRecord::Migration
  def change
    remove_column :master_traits, :is_feature, :boolean
  end
end
