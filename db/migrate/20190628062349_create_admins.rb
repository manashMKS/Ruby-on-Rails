class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins,id: :uuid do |t|
      t.string :email
      t.string :password
      t.string :password_digest
      t.string :user_agent
      t.string :remote_ip

      t.timestamps
    end
  end
end
