class Characteristic < ActiveRecord::Base
  has_many  :characteristic_monsters, dependent: :destroy

  def to_s
    name
  end

  ## Convert a number to conform with step_size; a step of 1 indicates
  ## integers, etc.
  def normalize(number)
    if step_size.nil? || step_size == step_size.to_i
      return number.to_i
    else
      return (number/step_size).to_i * step_size
    end
  end
end