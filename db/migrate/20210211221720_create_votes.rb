class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      # t.integer :content #NOT REQUIRED!!! we will just use present / not present logic
      t.references :user, null: false, foreign_key: true
      t.references :quote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
