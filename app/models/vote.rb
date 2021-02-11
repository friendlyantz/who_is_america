class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :quote

  validates :quote, uniqueness: { scope: :user }
end
