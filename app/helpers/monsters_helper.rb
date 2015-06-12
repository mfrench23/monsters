module MonstersHelper
  def monster_alias_list(monster)
    monster.monster_names.sort.collect { |x| x.to_s }.join('; ')
  end
end
