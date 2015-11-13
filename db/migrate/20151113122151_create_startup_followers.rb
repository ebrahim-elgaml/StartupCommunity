class CreateStartupFollowers < ActiveRecord::Migration
  def change
    create_table :startup_followers do |t|
      t.integer :startup_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
