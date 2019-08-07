class CreateUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_roles, id: :uuid do |t|
    	t.string :name
    	t.string :hierarchy
    	t.string :desc
      	t.references :user, type: :uuid,foreign_key: true
		t.timestamps
    end
  end
end
