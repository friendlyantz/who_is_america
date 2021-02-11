class SourceTracker < ApplicationRecord
  has_many :quotes

  enum reliability_by_admin: [:unconfirmed, :reliable, :unreliable]
end
