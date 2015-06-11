class WelcomeController < ApplicationController
  def index
    javascript_variables({:countbyclassdata => class_series})
    javascript_variables({:countbycreateddate => date_series("created_at", :created_on)})
    javascript_variables({:countbyupdateddate => date_series("updated_at", :updated_on)})
  end

  def class_series
    MonsterClass.find_each.select{|mc| mc.monsters_count.to_i > 0 }.map do |mc|
      { :name => mc.name, :y => mc.monsters_count, :url => monster_class_path(mc) }
    end
  end

  def date_series(date_field, scope)
    Monster.group("date(#{date_field})").count.reduce([]) do |memo, (k, v)|
      # Date.to_time.to_i gives seconds since epoch, but Highchart expects milliseconds, so convert
      memo << { :x => k.to_time.to_i * 1000, :y => v, :url => monsters_path(scope => k) }
    end
  end
end
