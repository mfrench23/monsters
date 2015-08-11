class WelcomeController < ApplicationController
  def index
    javascript_variables({:countbyclassdata => class_series})
    javascript_variables({:raw_series => series_array})
  end

  private

  def series_array
    series_array = created_on_and_updated_on_series_for(Monster)
    series_array += created_on_and_updated_on_series_for(EquipmentType)
  end

  def created_on_and_updated_on_series_for(klass)
    title = klass.to_s.pluralize.titleize
    [series_header_and_data("#{title} created", date_series(klass, "created_at", :created_on) ),
      series_header_and_data("#{title} modified", date_series(klass, "updated_at", :updated_on) ) ]
  end

  def series_header_and_data( header, data_series )
    { :key => header, :val => data_series }
  end

  def class_series
    MonsterClass.find_each.select{|mc| mc.monsters_count.to_i > 0 }.map do |mc|
      { :name => mc.name, :y => mc.monsters_count, :url => monster_class_path(mc) }
    end
  end

  def date_series(klass, date_field, scope)
    klass.group("date(#{date_field})").count.reduce([]) do |memo, (k, v)|
      memo << { :x => k.to_time.to_f * 1000, :y => v, :url => monsters_path(scope => k) }
    end
  end
end
