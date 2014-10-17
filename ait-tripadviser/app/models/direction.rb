class Direction < ActiveRecord::Base
  belongs_to :origin, :class_name => "Place"
  belongs_to :destination, :class_name => "Place"
  belongs_to :transportation
  belongs_to :created_by, class_name: "User", foreign_key: 'user_id'

end
