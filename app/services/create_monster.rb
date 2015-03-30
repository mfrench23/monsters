class CreateMonster
  attr_reader :form

  def initialize(form=nil)
    @form = form
  end

  def call
    monster = Monster.new(@form.params)
    monster.save
    return monster
  end
end