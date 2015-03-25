class UpdateMonster
  attr_reader :form
  attr_reader :id
  
  def initialize(id=nil, form=nil)
    @form = form
    @id = id
  end
  
  def call
    monster = Monster.find(@id)
    monster.update(@form.params)
    return monster
  end
end
