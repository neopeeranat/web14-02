json.array!(@quotations) do |quotation|
  json.extract! quotation, :id, :quote, :author_name, :category_id
  json.url quotation_url(quotation, format: :json)
end
