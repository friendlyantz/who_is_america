class CreateUserTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_trackers do |t|
      t.references :politician, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :match_ratio

      t.timestamps
    end
  end
end
