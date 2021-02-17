class UserTracker < ApplicationRecord
  belongs_to :politician
  belongs_to :user
end
