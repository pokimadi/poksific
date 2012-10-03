class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :type
      t.string :url
      t.string :title
      t.string :about
      t.integer :user_id
      t.string :embedid
      t.integer :view

      t.timestamps
    end
    add_index :uploads, [:user_id, :created_at]
  end
end
