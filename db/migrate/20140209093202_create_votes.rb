class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :post, index: true
      t.integer :contest_id

      t.timestamps
    end
    add_index :votes, [:user_id, :post_id, :contest_id]
  end
end
