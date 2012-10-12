class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :body
      t.references :upload

      t.timestamps
    end
    add_index :comments, :upload_id
  end
end
