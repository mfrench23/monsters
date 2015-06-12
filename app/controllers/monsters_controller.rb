class MonstersController < ApplicationController
  helper_method :sortable

  def index
    render locals: {
      monsters: filtered_results(params).includes(:monster_names, :monster_class).order(sort_param).page(params[:page]),
      filter_params: filter_params(params),
      starts_with_tags: filtered_results(params).group("substr(upper(name), 1,1)").count.keys.sort
    }
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction} quiet" : "quiet"
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    view_context.link_to title, filter_params(params).merge({:sort => column, :direction => direction}), {:class => css_class}
  end

  private

  def filtered_results(params)
    Monster.filter(filter_params(params))
  end

  def filter_params(params)
    params.slice(:starting_with, :created_on, :updated_on)
  end

  def sort_param
    sort_column + " " + sort_direction
  end

  def sort_column
    is_acceptable_sort_column(Monster, params[:sort]) ? params[:sort] : "monsters.name"
  end

  def is_acceptable_sort_column(klass, column)
    return false if column.blank?
    if m = column.match(/^(.*?)\.(.*)$/)
      association_name = m[1].singularize
      reflection = klass.reflect_on_association(association_name)
      if( reflection )
        return is_acceptable_sort_column(reflection.klass, m[2])
      else
        return false
      end
    else
      return klass.column_names.include?(column)
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
