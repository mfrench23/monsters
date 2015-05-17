class MonsterFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    options.merge!({ :class => "field-label" })
    super
  end
end
