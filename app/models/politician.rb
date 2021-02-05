class Politician < ApplicationRecord
  belongs_to :location, class_name: "Location", foreign_key: "location_id"
  has_many :quotes
end
