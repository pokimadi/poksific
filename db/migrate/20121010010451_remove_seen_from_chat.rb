class RemoveSeenFromChat < ActiveRecord::Migration
  def up
    remove_column :chats, :seen
  end

  def down
    add_column :chats, :seen, :boolean
  end
end
