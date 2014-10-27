class Transportation < ActiveRecord::Base
  has_many :directions, dependent: :destroy
  #can not use "type" because "type" come from inheritance, use this line to fixed
  self.inheritance_column = :_type_disabled
  def to_s
    "#{type}"
  end
end
