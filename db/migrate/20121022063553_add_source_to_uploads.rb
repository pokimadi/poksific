class AddSourceToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :source, :string , :default => 'youtube'
  end
end
