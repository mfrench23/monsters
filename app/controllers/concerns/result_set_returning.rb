module ResultSetReturning
  extend ActiveSupport::Concern

  private

  def filtered_sorted_paginated_results
    filtered_sorted_results.page(params[:page])
  end

  def filtered_sorted_results
    filtered_results.includes(includes_for_sorting).order(sort_params(controlled_model_class))
  end

  def sort_params(klass)
    view_context.sort_param(klass, params[:sort], params[:direction])
  end

  # Array of tables that need to be included because they might be used for sorting.
  def includes_for_sorting
    []
  end

  def filtered_results
    controlled_model_class.filter(filter_params)
  end

  def filter_params
    params.slice(*acceptable_filter_scopes)
  end

  # A list of scopes that are allowed to be used as filters.
  def acceptable_filter_scopes
    []
  end

  # The model class that this controller is in charge of.
  def controlled_model_class
    controller_path.classify.constantize
  end

  # The model name, as a symbol (i.e., MonsterName becomes :monster_name)
  def controlled_model_symbol
    controlled_model_class.to_s.underscore.to_sym
  end

  def controlled_model_plural_symbol
    controlled_model_class.to_s.pluralize.underscore.to_sym
  end

  def controlled_model_class_name
    controlled_model_class.to_s
  end
end