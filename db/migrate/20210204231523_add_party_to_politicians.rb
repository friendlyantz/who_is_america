class AddPartyToPoliticians < ActiveRecord::Migration[6.0]
  def change
    add_column :politicians, :party, :string
  end
end
