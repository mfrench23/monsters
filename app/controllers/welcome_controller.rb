class WelcomeController < ApplicationController
  def index
    javascript_variables({:countbyclassdata => class_series})
    javascript_variables({:countbycreateddate => date_series("created_at")})
    javascript_variables({:countbyupdateddate => date_series("updated_at")})
  end

  def class_series
    MonsterClass.find_each.select{|mc| mc.monsters_count.to_i > 0 }.map do |mc|
      { :name => mc.name, :y => mc.monsters_count, :url => monster_class_path(mc) }
    end
  end

  def date_series(date_field)
    Monster.group("date(#{date_field})").count.reduce([]) do |memo, (k, v)|
      memo << [ k, v ]
    end
  end
end
