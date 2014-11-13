class Direction < ActiveRecord::Base
  belongs_to :origin, :class_name => "Place"
  belongs_to :destination, :class_name => "Place"
  belongs_to :transportation
  belongs_to :created_by, class_name: "User", foreign_key: 'user_id'

  validates :origin_id, presence: true, uniqueness: { scope: [:destination_id, :transportation_id, :user_id], message: "You already create this direction."}
  validates :destination_id, :price, :transportation_id, :user_id, presence: true
  def to_enum
    "#{destination_id}"
  end
end
