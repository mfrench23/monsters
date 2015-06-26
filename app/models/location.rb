class Location < AbstractEntity
  has_many  :damage_resistances, :dependent => :destroy

  validates :name, presence: true

  scope :order_by_name, -> { order(:name) }

  def to_s
    name
  end
end
