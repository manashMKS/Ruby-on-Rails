class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions,id: :uuid do |t|
      t.string :permission
      t.references :user_role,type: :uuid, foreign_key: true
      t.references :menu,type: :uuid, foreign_key: true
      t.string :role
      t.string :menus
      t.string :action
      t.timestamps
    end
  end
end
