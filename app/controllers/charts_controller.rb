class ChartsController < ApplicationController
  def monsters_by_class
    render json: Monster.joins("inner join monster_classes on monster_classes.id = monsters.monster_class_id").group("monster_classes.name").count
  end

  def monsters_by_creation_date
    render json: Monster.group("date(created_at)").count
  end
end
