class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.integer :chat_id
      t.integer :user_id

      t.timestamps
    end
    add_index :communications, :chat_id
    add_index :communications, :user_id
  end
end
