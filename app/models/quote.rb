class Quote < ApplicationRecord
  belongs_to :politician
  belongs_to :creator, foreign_key: 'creator_id', class_name: 'User'
  belongs_to :source_tracker

  has_many :child_quotes, class_name: "Quote", foreign_key: "parent_quote_id"
  belongs_to :parent_quote, class_name: "Quote", optional: true

  has_many :votes
  
  validates_length_of :content, within: 10..100, on: :create, message: "must be present"

  enum approval_status: [:pending, :declined, :accepted, :archived]
end
