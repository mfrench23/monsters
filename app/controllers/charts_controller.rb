class ChartsController < ApplicationController
  def monsters_by_class
    render json: Monster.joins("inner join monster_classes on monster_classes.id = monsters.monster_class_id").group("monster_classes.name").count
  end
end
