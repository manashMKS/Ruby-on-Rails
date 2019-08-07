class AddOnetimepasswordToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :onetimepassword, :integer
  end
end
