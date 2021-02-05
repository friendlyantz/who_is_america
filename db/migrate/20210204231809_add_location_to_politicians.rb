class AddLocationToPoliticians < ActiveRecord::Migration[6.0]
  def change
    add_reference :politicians, :location, null: false, index: true, foreign_key: { to_table: :locations }
  end
end
