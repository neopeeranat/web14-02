class Category < ActiveRecord::Base
  has_many :places
  accepts_nested_attributes_for :places
end
