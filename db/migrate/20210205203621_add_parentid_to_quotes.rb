class AddParentidToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :quotes, :parent_quote, null: true, foreign_key: { to_table: :quotes }
  end
end
