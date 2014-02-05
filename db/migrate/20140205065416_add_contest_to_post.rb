class AddContestToPost < ActiveRecord::Migration
  def change
    add_column :posts, :contest_id, :integer
    add_column :posts, :contest_type, :string
  end
end
