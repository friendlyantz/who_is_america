class CreateSourceTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :source_trackers do |t|
      t.string :name
      t.integer :reliability_by_admin, default: 0

      t.timestamps
    end
  end
end
