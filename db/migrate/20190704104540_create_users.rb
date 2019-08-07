class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users ,id: :uuid do |t|
    t.string :name
    t.string :email
    t.string :phone
    t.string :password
    t.string :password_confirmation
    t.integer :onetimepassword
    t.string :avatar
    t.string :password_digest
    t.string :provider
    t.string :uid
    t.string :user_role_id 
    t.string :reset_digest
    t.string :user_agent
    t.string :remote_ip
    t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
