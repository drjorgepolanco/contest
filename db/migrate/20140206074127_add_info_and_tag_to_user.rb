class AddInfoAndTagToUser < ActiveRecord::Migration
  def change
    add_column :users, :info, :text
    add_column :users, :tag, :string
  end
end
