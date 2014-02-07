class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.references :user, index: true
      t.string :title
      t.text :description
      t.integer :views
      t.string :tag
      t.string :image

      t.timestamps
    end
    add_index :polls, [:user_id, :created_at]
  end
end
