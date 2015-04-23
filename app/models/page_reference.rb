class PageReference < ActiveRecord::Base
  belongs_to :book
  belongs_to :monster

  def to_s
    s = ""
    pg = ""
    if not pages.nil?
      pg = "p. " + pages
    end

    if book.nil?
      s = pg
    else
      s = ( (book.abbreviation.nil? or book.abbreviation.empty?) ? book.name : book.abbreviation ) + " #{pg}"
    end
    s.strip
  end
end
