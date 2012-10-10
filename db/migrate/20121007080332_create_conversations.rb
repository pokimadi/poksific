class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :chat_id
      t.string :message , :limit => 10000

      t.timestamps 
    end
    add_index :conversations, :chat_id
  end
end
