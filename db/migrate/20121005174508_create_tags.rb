class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :upload

      t.timestamps
    end
    add_index :tags, :upload_id
  end
end
