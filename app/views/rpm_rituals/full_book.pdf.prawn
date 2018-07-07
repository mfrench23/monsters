def text_or_none(text)
  "None." unless text.present?
  text
end

def label_and_text(pdf, label, text)
  pdf.formatted_text [{:text => label, :styles => [:italic]}, {:text => text}]
end

def ritual_descriptions(pdf, view_context, campaign)
  pdf.column_box([0, pdf.cursor], :columns => 2, :width => pdf.bounds.width) do
    campaign.rpm_rituals.includes(:rpm_spell_effects).order_by_name.each do |ritual|
      one_ritual pdf, view_context, ritual
    end
  end
end

def one_ritual(pdf, view_context, ritual)
  pdf.font("Helvetica", :size => 10) do
    pdf.formatted_text [{:text => ritual.name, :styles => [:bold]}]
  end

  txt = text_or_none(view_context.rpm_inherent_spell_effects_text(ritual))
  label_and_text pdf, "Spell Effects: ", txt

  txt = text_or_none(view_context.rpm_inherent_spell_modifiers_text(ritual))
  label_and_text pdf, "Inherent Modifiers: ", txt

  label_and_text pdf, "Greater Effects: ", "#{ritual.rpm_spell_effects.inherent_only.greater_effect.count} (x#{ritual.inherent_cost_factor})"

  pdf.move_down 6

  # remove non-ASCII characters
  pdf.font("Helvetica", :size => 10) do
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => '',        # Use a blank for those replacements
      :universal_newline => true       # Always break lines with \n
      }
    txt = ""
    txt = ritual.description.encode(Encoding.find('ASCII'), encoding_options) if ritual.description.present?
    pdf.text "#{txt}"
  end

  pdf.move_down 6

  txt = ritual.all_elements.collect(&:to_long_s).join(" + ")
  pdf.text "<i>Typical Casting:</i> #{txt}. <i>#{ritual.typical_cost} energy (#{ritual.base_cost} x #{ritual.overall_cost_factor}).</i>", :inline_format => true

  pdf.move_down 6

  pdf.text "<i>Recommended skill:</i> #{ritual.effective_skill}", :inline_format => true
  pdf.move_down 6

  if ritual.page_references.any?
    txt = ritual.page_references.inject([]) { |memo, pg| memo << pg.to_s }.join("; ")
    label_and_text pdf, "Sources: ", txt
  end
      
  pdf.move_down 18
end

prawn_document(:page_layout => :portrait, :top_margin => 50 ) do |pdf|
  pdf.font "Helvetica", :size => 9
  pdf.repeat(:all) do
    pdf.text_box "<i>Campaign:</i> #{campaign.name}", :at => [pdf.bounds.left, pdf.bounds.top + 20], :size => 7, :width => 150, :inline_format => true
    pdf.text_box "<i>as of</i> #{Time.now.strftime('%-d %b %Y %H:%M:%S %Z')}", :at => [pdf.bounds.right - 150, pdf.bounds.top + 20], :size => 7, :align => :right, :width => 150, :inline_format => true
  end

  ritual_descriptions pdf, view_context, campaign

  pdf.number_pages "Pg <page>/<total>", { :at => [pdf.bounds.right - 150, 0], :width => 150, :align => :right, :size => 7 }
end

