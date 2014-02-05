class AddContestIndexToPost < ActiveRecord::Migration
  def change
  end
  add_index :posts, [:contest_id, :contest_type]
end
