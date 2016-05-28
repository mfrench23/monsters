# A particular GURPS Characteristic, like ST or HT
class Characteristic < AbstractEntity
  has_many  :characteristic_monsters, dependent: :destroy
  has_many  :characteristic_lists, dependent: :destroy

  def to_s
    name
  end

  ## Convert a number to conform with step_size; a step of 1 indicates
  ## integers, etc.
  def normalize(number)
    return nil if number.blank?
    step = step_size || 1
    result = (number/step_size).to_i * step_size
    return (step == step.to_i ? result.to_i : result )
  end
end
