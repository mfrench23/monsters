class BooksController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:book).permit(:name, :abbreviation)
  end

  def acceptable_filter_scopes
    [:starting_with]
  end
end
