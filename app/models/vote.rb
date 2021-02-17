class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :quote

  enum votes: [ :dislike, :like ]

  validates :quote, uniqueness: { scope: :user }
end
