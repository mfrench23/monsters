class Illustration < AbstractEntity
  belongs_to :illustratable, :polymorphic => true

  has_attached_file :image,
      :styles => { :medium => "300x300>", :small => "75x75>" }
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :image, :less_than => (0.5).megabytes

  def deep_copy
    dup
  end
end
