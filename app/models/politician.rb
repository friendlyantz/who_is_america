class Politician < ApplicationRecord
  belongs_to :location, class_name: "Location", foreign_key: "location_id"
  has_many :quotes
  has_many :user_trackers
  has_one_attached :photo 

end
