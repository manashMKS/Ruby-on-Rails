class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus,id: :uuid do |t|
      t.string :menu
      t.string :description

      t.timestamps
    end
  end
end
