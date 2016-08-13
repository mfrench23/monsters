module PageReferencesHelper
  def page_references_compact(obj, separator=", ")
    return unless obj.try(:page_references).present?
    obj.page_references.inject([]) { |memo, pg| memo << link_to(pg.to_s, pg.book, class: "quiet") }.join(separator).html_safe
  end
end
