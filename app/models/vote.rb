class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :quote

  enum votes: %i[dislike like]

  validates :quote, uniqueness: { scope: :user }
  validates :content, presence: true
end
