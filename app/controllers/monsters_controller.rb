class MonstersController < ApplicationController
  helper_method :sortable

  def index
    @monsters = Monster.filter(params.slice(:starts_with)).order(sort_param).includes(:monster_names, :monster_class, characteristic_monsters: [:characteristic] ).page params[:page]
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    view_context.link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  private

  def sort_param
    sort_column + " " + sort_direction
  end

  def sort_column
    Monster.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
