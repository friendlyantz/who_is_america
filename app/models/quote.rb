class Quote < ApplicationRecord
  belongs_to :politician
  belongs_to :creator, foreign_key: 'creator_id', class_name: 'User'

  enum approval_status: [:pending, :declined, :accepted]
end
