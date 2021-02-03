class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :location_type
      t.references :parent_location, foreign_key: { to_table: :locations }

      t.timestamps
    end
  end
end
