class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.boolean :seen , default: false

      t.timestamps
    end
  end
end
