class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :profile_pic
      t.date :date_of_birth

      t.timestamps
    end
  end
end
