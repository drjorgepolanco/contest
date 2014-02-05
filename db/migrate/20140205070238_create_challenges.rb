class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.references :user, index: true
      t.string :title
      t.text :description
      t.integer :views
      t.string :tag
      t.string :image

      t.timestamps
    end
    add_index :challenges, [:user_id, :created_at]
  end
end
