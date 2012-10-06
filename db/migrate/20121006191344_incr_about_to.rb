class IncrAboutTo < ActiveRecord::Migration
  def change
    change_column :uploads, :about, :string, :limit => 10000
  end
end
