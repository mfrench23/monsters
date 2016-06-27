# An entity which will set a list of attributes to nil if they are blank, to avoid
# future worries over different "empty field" values
module NilBlankable
  private

  def nil_blank_attributes
    [*blankable_attributes].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end