class CreateStaticContents < ActiveRecord::Migration[5.2]
  def change
    create_table :static_contents,id: :uuid do |t|
      t.string :title
      t.string :old_content
      t.string :latest_content
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
