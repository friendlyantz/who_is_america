class AddPermissionsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :permissions, :integer, null: false, default: 0
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
