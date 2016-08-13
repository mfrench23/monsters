module CharacteristicsHelper
  def show_stat(val)
    value = val || 'n/a'
    content_tag( :span, value )
  end
end
