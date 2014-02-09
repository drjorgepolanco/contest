class AddUpToVote < ActiveRecord::Migration
  def change
    add_column :votes, :up, :boolean
  end
end
