class AddSeenToCommunications < ActiveRecord::Migration
  def change
    add_column :communications, :seen, :boolean, default: false
  end
end
