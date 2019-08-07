class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions,id: :uuid do |t|
      t.references :menu,type: :uuid, foreign_key: true
      t.string :action

      t.timestamps
    end
  end
end
