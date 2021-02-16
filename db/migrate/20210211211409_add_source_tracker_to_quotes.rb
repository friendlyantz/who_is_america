class AddSourceTrackerToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :quotes, :source_tracker, null: true, index: true, foreign_key: true
  end
end
