class CreateUserGroupRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_group_roles,id: :uuid do |t|
      t.references :user,type: :uuid, foreign_key: true
      t.references :user_role,type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
