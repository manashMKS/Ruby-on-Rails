class AddTokenIdToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :token_id, :string
  end
end
