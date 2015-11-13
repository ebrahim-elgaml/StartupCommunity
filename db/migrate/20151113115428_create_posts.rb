class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.string :image
      t.integer :user_id
      t.integer :startup_id
      t.integer :tagged_id

      t.timestamps null: false
    end
  end
end
