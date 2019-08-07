class ErrorMessages < ActiveRecord::Migration[5.2]
create_table :error_messages do |t|
   t.text :class_name
   t.text :message
   t.text :trace
   t.text :params
   t.text :target_url
   t.text :referer_url
   t.text :user_agent
   t.string :user_info
   t.string :app_name
   t.string :doc_root
   t.string :methodssage
t.timestamps
end

end
