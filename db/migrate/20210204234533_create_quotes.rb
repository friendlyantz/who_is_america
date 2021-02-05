class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.text :content, null: false
      t.text :source_link, null: false
      t.integer :approval_status, null: false, default: 0
      t.references :politician, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
