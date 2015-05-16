class Illustration < ActiveRecord::Base
  belongs_to :illustratable, :polymorphic => true

  has_attached_file :image,
      :styles => { :medium => "300x300>", :small => "75x75>" },
      :default_url => "/images/:style/missing.png"
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :image, :less_than => (0.5).megabytes
end
