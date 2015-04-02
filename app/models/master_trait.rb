class MasterTrait < ActiveRecord::Base
   validates :name, presence: true

   def to_s
     (is_feature ? "Feature: " : "") + name + (notes.nil? ? "" : " (" + notes + ")")
   end
end
