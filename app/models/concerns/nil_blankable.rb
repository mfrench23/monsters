module NilBlankable
  private

  def nil_blank_attributes
    [*blankable_attributes].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end