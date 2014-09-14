class Quotation < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :quote
  validates_presence_of :author_name
  validates_presence_of :category_id

  def self.search(query)
    where("lower(quote) like ? OR lower(author_name) like ?", "%#{query.downcase}%", "%#{query.downcase}%")
  end
end
