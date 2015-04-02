module MonsterNamesHelper
  def simpleMonsterNames(monster)
    monster.monster_names.sort.collect { |x| x.name + (x.primary ? ' * ' : '') }.join('; ')
  end
end
