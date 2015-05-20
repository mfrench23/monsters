class Skill::ActualOrModifierValidator < ActiveModel::Validator
  def validate(record)
    if record.actual.blank? && record.modifier.blank?
      record.errors[:modifier] << "Either 'modifier' or 'actual' must be populated"
    end
  end
end
