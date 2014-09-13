class Quotation < ActiveRecord::Base
  belongs_to :category
  def self.search(query)
    where("lower(quote) like ? OR lower(author_name) like ?", "%#{query.downcase}%", "%#{query.downcase}%")
  end
end
