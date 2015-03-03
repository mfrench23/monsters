json.array!(@page_references) do |page_reference|
  json.extract! page_reference, :id, :book_id, :monster_id, :pages
  json.url page_reference_url(page_reference, format: :json)
end
